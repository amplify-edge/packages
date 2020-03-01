package grpc

import (
	"context"
	"log"
	"net"

	v1 "github.com/getcouragenow/packages/mod-chat/server/grpc-web/pkg/api/v1"
	"google.golang.org/grpc"
)

// RunServer registers gRPC service and run server
func RunServer(ctx context.Context, srv v1.ChatServiceServer, port string) error {
	listen, err := net.Listen("tcp", ":"+port)
	if err != nil {
		return err
	}

	// register service
	server := grpc.NewServer()
	v1.RegisterChatServiceServer(server, srv)

	// start gRPC server
	log.Println("starting gRPC server...")
	return server.Serve(listen)
}
