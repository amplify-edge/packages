package main

import (
	"bufio"
	"context"
	"fmt"
	"os"

	v2 "github.com/getcouragenow/packages/mod-chat/server/grpc-web/pkg/api/v2"
	"google.golang.org/grpc"
)

var (
	addr     = ":9074"
	username = ""
	connID   = ""
)

func main() {

	// Connect to serveur
	conn, err := grpc.Dial(addr, grpc.WithInsecure())

	if err != nil {
		panic(err)
	}

	defer conn.Close()
	input := ""

	// get username
	fmt.Print("You username:")
	fmt.Scanln(&input)
	username = input

	// get friend name
	fmt.Print("friend username:")
	fmt.Scanln(&input)
	friend := input

	// create client
	client := v2.NewChatServiceClient(conn)

	// subscribe to stream
	stream, err := client.Subscribe(context.Background(),
		&v2.Request{Username: username, Friend: friend})

	if err != nil {
		fmt.Println("Error subscribe")
		panic(err)
	}

	// recieve connection id from serveur
	m, err := stream.Recv()
	if err != nil {
		panic(err)
	}
	connID = m.ConnID

	fmt.Println("Connection ID:", connID)

	// Listen for new messages
	go func() {
		for {
			message, err := stream.Recv()
			if err != nil {
				fmt.Println(err)
				return
			}

			fmt.Printf("%s : %s\n", message.FromUser, message.Text)
		}
	}()

	// Send messages
	input = ""
	r := bufio.NewReader(os.Stdin)
	for {

		input, _ = r.ReadString('\n')

		if input != "" {
			_, err := client.Send(context.Background(),
				&v2.Message{FromUser: username, ToUser: friend, Text: input, ConnID: connID})
			if err != nil {
				fmt.Println("Could not send msg:", err)
				return
			}

		}
	}
}
