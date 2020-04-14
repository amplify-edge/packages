package main

import (
	"context"
	api "github.com/getcouragenow/packages/mod-main/server/pkg/api"
	"github.com/getcouragenow/packages/mod-main/server/pkg/service"
	"google.golang.org/grpc"
	glog "google.golang.org/grpc/grpclog"
	"net"
	"os"
	"os/signal"
	"syscall"
)
// TODO need environment vars 
func main() {
	logger := glog.NewLoggerV2(os.Stdout, os.Stdout, os.Stdout)

	ctx := context.Background()
	ctx, cancel := context.WithCancel(ctx)
	defer cancel()

	// graceful shutdown
	interrupt := make(chan os.Signal, 1)
	signal.Notify(interrupt, os.Interrupt, syscall.SIGTERM)
	defer signal.Stop(interrupt)

	srv, err := service.New(ctx, "answers", logger)
	if err != nil {
		logger.Fatal("Error when creating mod-main server: %s", err.Error())
	}

	grpcServer := grpc.NewServer()
	lis, err := net.Listen("tcp", ":8081")
	if err != nil {
		logger.Fatalf("Error when creating server: %v", err)
	}

	api.RegisterQuestionServer(grpcServer, srv)
	go grpcServer.Serve(lis)

	select {
	case <-ctx.Done():
		break
	case <-interrupt:
		break
	}

	cancel()
	logger.Warningln("Receive termination signal")

	grpcServer.GracefulStop()
}
