package v1

import (
	"context"
	"fmt"
	"log"

	"github.com/golang/protobuf/ptypes/empty"
	"github.com/golang/protobuf/ptypes/wrappers"
	lb "github.com/liftbridge-io/go-liftbridge"

	v1 "github.com/getcouragenow/packages/mod-chat/server/grpc-web/pkg/api/v1"
)

var (
	addr    = "localhost:9292"
	name    = "chat"
	subject = "chat-stream"
)

// chatServiceServer is implementation of v1.ChatServiceServer proto interface
type chatServiceServer struct {
	msg    chan string
	client lb.Client
}

// NewChatServiceServer creates Chat service object
func NewChatServiceServer() v1.ChatServiceServer {
	client, err := lb.Connect([]string{addr})
	if err != nil {
		panic(err)
	}

	client.CreateStream(context.Background(), subject, name)

	return &chatServiceServer{client: client}
}

// Send sends message to the server
func (s *chatServiceServer) Send(ctx context.Context, message *wrappers.StringValue) (*empty.Empty, error) {
	if message != nil {
		log.Printf("Send requested: message=%v", *message)
		_, err := s.client.Publish(ctx, name, []byte(message.Value), lb.AckPolicyAll())

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
func (s *chatServiceServer) Subscribe(e *empty.Empty, stream v1.ChatService_SubscribeServer) error {

	s.client.Subscribe(context.Background(), subject, func(msg lb.Message, err error) {
		if err != nil {
			panic(err)
		}

		fmt.Println("Received message", string(msg.Value()))
		s.msg <- string(msg.Value())
	})

	for {
		m := <-s.msg
		n := v1.Message{Text: fmt.Sprintf("I have received from you: %s. Thanks!", m)}
		if err := stream.Send(&n); err != nil {
			// put message back to the channel
			s.msg <- m
			log.Printf("Stream connection failed: %v", err)
			return nil
		}
		log.Printf("Message sent: %+v", n)
	}
	// log.Print("Subscribe requested")

}
