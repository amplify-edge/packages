package main

import (
	"context"
	"fmt"
	"os"

	"github.com/amsokol/flutter-grpc-tutorial/go-server/pkg/protocol/grpc"
	v1 "github.com/amsokol/flutter-grpc-tutorial/go-server/pkg/service/v1"
)

func main() {
	if err := grpc.RunServer(context.Background(), v1.NewChatServiceServer(), "9074"); err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		os.Exit(1)
	}
}
