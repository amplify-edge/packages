package v2

import (
	"context"
	"fmt"
	"log"
	"strings"
	"sync"

	proto "github.com/getcouragenow/packages/mod-chat/server/grpc-web/pkg/api/liftbridge"
	v2 "github.com/getcouragenow/packages/mod-chat/server/grpc-web/pkg/api/v2"
	uuid "github.com/satori/go.uuid"
)

var (
	addr     = "localhost:9292"
	name     = "chat"
	subject  = "chat-stream"
	messages = []string{}
)

type connection struct {
	id       string
	user     string
	stream   v2.ChatService_SubscribeServer
	err      chan error
	messages chan messageTo
}

type messageTo struct {
	connID  string
	to      []string
	message *v2.Message
}

// chatServiceServer is implementation of v2.ChatServiceServer proto interface
type chatServiceServer struct {
	mu          sync.Mutex
	client      proto.APIClient
	msg         chan messageTo
	sub         chan *connection
	unsub       chan *connection
	connections []*connection
}

// NewChatServiceServer creates Chat service object
func NewChatServiceServer(client proto.APIClient) v2.ChatServiceServer {

	service := &chatServiceServer{
		client:      client,
		msg:         make(chan messageTo, 1000),
		sub:         make(chan *connection),
		unsub:       make(chan *connection),
		connections: []*connection{},
	}

	go service.start()
	return service
}

// Send sends message to the server
func (s *chatServiceServer) Send(ctx context.Context, message *v2.Message) (*v2.Response, error) {

	if message != nil {
		log.Printf("Send requested FROM: %s - TO: %s", message.FromUser, message.ToUser)

		// Publish message to liftbridge
		msg := fmt.Sprintf("%s:%s:%s:%s", message.FromUser, message.ToUser, message.Text, message.ConnID)

		_, err := s.client.Publish(
			context.Background(),
			&proto.PublishRequest{Value: []byte(msg), Stream: message.FromUser})

		_, err = s.client.Publish(
			context.Background(),
			&proto.PublishRequest{Value: []byte(msg), Stream: message.ToUser})

		if err != nil {
			fmt.Println("Could not Publish message", err.Error())
			panic(err)
		}

		fmt.Println("published")
	} else {
		log.Print("Send requested: message=<empty>")
	}

	return &v2.Response{}, nil
}

// Subscribe is streaming method to get echo messages from the server
func (s *chatServiceServer) Subscribe(request *v2.Request, stream v2.ChatService_SubscribeServer) error {

	connID := uuid.NewV4().String()
	conn := &connection{
		id:       connID,
		user:     request.Username,
		stream:   stream,
		err:      make(chan error),
		messages: make(chan messageTo),
	}

	stream.Send(&v2.Message{ConnID: connID})

	// create a stream connection with liftbridge
	s.client.CreateStream(context.Background(),
		&proto.CreateStreamRequest{Subject: conn.user + "stream", Name: conn.user},
	)
	s.client.CreateStream(context.Background(),
		&proto.CreateStreamRequest{Subject: request.Friend + "stream", Name: request.Friend},
	)

	s.sub <- conn
	go s.fetch(conn.user, conn, proto.StartPosition_EARLIEST)

	err := <-conn.err
	s.unsub <- conn
	return err
}

// parse a message
func parseMessage(message string) *v2.Message {
	s := strings.Split(message, ":")
	return &v2.Message{FromUser: s[0], ToUser: s[1], Text: s[2], ConnID: s[3]}
}

func (s *chatServiceServer) start() {
	fmt.Println("Start service")

	for {
		select {

		// subscribe a user
		case conn := <-s.sub:
			s.mu.Lock()
			s.connections = append(s.connections, conn)
			s.mu.Unlock()
			break

		// unsubscribe a user
		case conn := <-s.unsub:
			s.mu.Lock()
			for i, c := range s.connections {
				if c.stream == conn.stream {
					s.connections = append(s.connections[:i], s.connections[i+1:]...)
				}
			}
			s.mu.Unlock()
			break
		}
	}
}

func (s *chatServiceServer) fetch(name string, conn *connection, pos proto.StartPosition) {

	sub, err := s.client.Subscribe(context.Background(),
		&proto.SubscribeRequest{
			Stream:        name,
			StartPosition: pos,
		})

	if err != nil {
		panic(err)
	}

	go func() {
		for {
			m := <-conn.messages
			err := conn.stream.Send(m.message)
			if err != nil {
				conn.err <- err
			}
		}
	}()

	for {
		m, err := sub.Recv()
		if err != nil {
			fmt.Println("Error subscribe to liftbridge")
			panic(err)
		}

		if string(m.Value) != "" {
			fmt.Println("Get message from liftbridge", m)
			message := parseMessage(string(m.Value))
			conn.messages <- messageTo{
				connID:  message.ConnID,
				to:      []string{message.FromUser, message.ToUser},
				message: message,
			}
		}
	}
}
