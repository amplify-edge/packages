package main

import (
	"os"

	v2 "github.com/getcouragenow/packages/mod-chat/server/grpc-web/pkg/service/v2"
	"google.golang.org/grpc"

	proto "github.com/getcouragenow/packages/mod-chat/server/grpc-web/pkg/api/liftbridge"
	grpcv2 "github.com/getcouragenow/packages/mod-chat/server/grpc-web/pkg/protocol/grpc/v2"

	"context"
	"fmt"
)

var (
	addr    = "localhost:9292"
	name    = "chat"
	subject = "chat-stream"
)

func main() {
	// connect to liftbridge
	conn, err := grpc.Dial(addr, grpc.WithInsecure())
	defer conn.Close()
	if err != nil {
		panic(err)
	}

	// Create a stream
	client := proto.NewAPIClient(conn)

	if err := grpcv2.RunServer(context.Background(), v2.NewChatServiceServer(client), "9074"); err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		os.Exit(1)
	}
}
