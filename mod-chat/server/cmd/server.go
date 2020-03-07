package main

import (
	"net"

	"log"

	"github.com/getcouragenow/packages/mod-chat/server/pkg/api"
	"github.com/getcouragenow/packages/mod-chat/server/pkg/service"
	"google.golang.org/grpc"

	stan "github.com/nats-io/stan.go"
)

func main() {
	conn, err := stan.Connect("test-cluster", "test-client")
	if err != nil {
		log.Fatal(err)
	}
	defer conn.Close()

	server := &service.Server{conn}

	grpcServer := grpc.NewServer()
	listener, err := net.Listen("tcp", ":8080")
	if err != nil {
		log.Fatalf("error creating the server %v", err)
	}

	api.RegisterBroadcastServer(grpcServer, server)

	grpcServer.Serve(listener)
}
