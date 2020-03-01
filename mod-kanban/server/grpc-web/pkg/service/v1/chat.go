package v1

import (
	"context"
	"fmt"
	"log"

	"github.com/golang/protobuf/ptypes/empty"
	"github.com/golang/protobuf/ptypes/wrappers"
	"google.golang.org/grpc"

	proto "github.com/getcouragenow/packages/mod-chat/server/grpc-web/pkg/api/liftbridge"
	v1 "github.com/getcouragenow/packages/mod-chat/server/grpc-web/pkg/api/v1"
)

var (
	addr    = "localhost:9292"
	name    = "chat"
	subject = "chat-stream"
)

// chatServiceServer is implementation of v1.ChatServiceServer proto interface
type chatServiceServer struct {
	// msg    chan string
	client proto.APIClient
}

// NewChatServiceServer creates Chat service object
func NewChatServiceServer() v1.ChatServiceServer {

	// connect to liftbridge
	conn, err := grpc.Dial(addr, grpc.WithInsecure())
	defer conn.Close()
	if err != nil {
		panic(err)
	}

	// Create a stream
	client := proto.NewAPIClient(conn)
	client.CreateStream(context.Background(),
		&proto.CreateStreamRequest{Subject: subject, Name: name},
	)
	// , msg: make(chan string, 1000)
	return &chatServiceServer{client: client}
}

// Send sends message to the server
func (s *chatServiceServer) Send(ctx context.Context, message *wrappers.StringValue) (*empty.Empty, error) {
	if message != nil {
		log.Printf("Send requested: message=%v", *message)

		// Publish message to liftbridge
		_, err := s.client.Publish(context.Background(), &proto.PublishRequest{Value: []byte(message.Value), Stream: name})
		if err != nil {
			fmt.Println("Could not Publish message", err.Error())
			panic(err)
		}
		fmt.Println("published")

		// s.msg <- message.Value
	} else {
		log.Print("Send requested: message=<empty>")
	}

	return &empty.Empty{}, nil
}

// Subscribe is streaming method to get echo messages from the server
func (s *chatServiceServer) Subscribe(e *empty.Empty, ss v1.ChatService_SubscribeServer) error {

	stream, err := s.client.Subscribe(context.Background(), &proto.SubscribeRequest{Stream: "chat"})

	if err != nil {
		panic(err)
	}
	for {
		m, err := stream.Recv()
		if err != nil {
			panic(err)
		}
		if m != nil {
			fmt.Println(string(m.Value))
		}
	}
	// for {
	// 	m := <-s.msg
	// 	n := v1.Message{Text: fmt.Sprintf("I have received from you: %s. Thanks!", m)}
	// 	if err := stream.Send(&n); err != nil {
	// 		// put message back to the channel
	// 		s.msg <- m
	// 		log.Printf("Stream connection failed: %v", err)
	// 		return nil
	// 	}
	// 	log.Printf("Message sent: %+v", n)
	// }
	// log.Print("Subscribe requested")
}
