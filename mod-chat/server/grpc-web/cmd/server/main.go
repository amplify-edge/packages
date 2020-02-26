package main

import (
	"os"

	v1 "github.com/getcouragenow/packages/mod-chat/server/grpc-web/pkg/service/v1"

	"github.com/getcouragenow/packages/mod-chat/server/grpc-web/pkg/protocol/grpc"

	"context"
	"fmt"
)

func main() {

	//////////////////////////TEST/////////////////////////////////
	// conn, err := grpc.Dial("localhost:9292", grpc.WithInsecure())
	// // conn, err := liftbridge.Connect([]string{"localhost:9292"})

	// defer conn.Close()
	// if err != nil {
	// 	panic(err)
	// }

	// client := proto.NewAPIClient(conn)
	// client.CreateStream(context.Background(),
	// 	&proto.CreateStreamRequest{Subject: "chat-stream", Name: "chat"},
	// )

	// go func() {
	// 	_, err = client.Publish(context.Background(), &proto.PublishRequest{Value: []byte("Hello"), Stream: "chat"})

	// 	_, err = client.Publish(context.Background(), &proto.PublishRequest{Value: []byte("Hello"), Stream: "chat"})

	// 	_, err = client.Publish(context.Background(), &proto.PublishRequest{Value: []byte("Hello"), Stream: "chat"})
	// }()

	// ctx := context.Background()
	// stream, err := client.Subscribe(ctx, &proto.SubscribeRequest{Stream: "chat"})

	// if err != nil {
	// 	panic(err)
	// }
	// for {
	// 	m, err := stream.Recv()
	// 	if err != nil {
	// 		panic(err)
	// 	}
	// 	if m != nil {
	// 		fmt.Println(string(m.Value))
	// 	}
	// }
	// <-ctx.Done()
	//////////////////////////TEST/////////////////////////////////

	if err := grpc.RunServer(context.Background(), v1.NewChatServiceServer(), "9074"); err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		os.Exit(1)
	}
}
