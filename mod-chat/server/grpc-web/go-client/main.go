package main

import (
	"context"
	"fmt"
	"log"

	v1 "github.com/getcouragenow/packages/mod-chat/server/grpc-web/pkg/api/v1"
	wrappers "github.com/golang/protobuf/ptypes/wrappers"

	"google.golang.org/grpc"
)

func main() {
	// Set up a connection to the server.
	conn, err := grpc.Dial(":9074", grpc.WithInsecure())
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()
	c := v1.NewChatServiceClient(conn)

	r, err := c.Send(context.Background(), &wrappers.StringValue{Value: "Hello"})
	if err != nil {
		log.Fatalf("could not greet: %v", err)
	}

	fmt.Println(r)
}

// Send(ctx context.Context, in *wrappers.StringValue, opts ...grpc.CallOption) (*empty.Empty, error)
// 	// Subscribe is streaming method to get echo messages from the server
// 	Subscribe(ctx context.Context, in *empty.Empty, opts ...grpc.CallOption) (ChatService_SubscribeClient, error)
