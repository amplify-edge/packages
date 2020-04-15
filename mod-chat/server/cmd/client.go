package main

import (
	"bufio"
	"crypto/sha256"
	"crypto/tls"
	"flag"
	"fmt"
	"os"

	proto "github.com/getcouragenow/packages/mod-chat/server/pkg/api"

	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"

	"encoding/hex"
	"log"
	"sync"
	"time"

	"github.com/johnsiilver/getcert"
	"golang.org/x/net/context"
)

var client proto.BroadcastClient
var wait *sync.WaitGroup

func init() {
	wait = &sync.WaitGroup{}
}

func connect(user *proto.User) error {
	var streamerror error

	stream, err := client.CreateStream(context.Background(), &proto.Connect{
		User: user,
	})

	if err != nil {
		return fmt.Errorf("connection failed: %v", err)
	}

	wait.Add(1)
	go func(str proto.Broadcast_CreateStreamClient) {
		defer wait.Done()

		for {
			msg, err := str.Recv()
			if err != nil {
				streamerror = fmt.Errorf("Error reading message: %v", err)
				break
			}

			fmt.Printf("%v : %s\n", msg.Id, msg.Content)

		}
	}(stream)

	return streamerror
}

func main() {
	timestamp := time.Now()
	done := make(chan int)

	name := flag.String("N", "Anon", "The name of the user")
	flag.Parse()

	id := sha256.Sum256([]byte(timestamp.String() + *name))

	// TODO: Add environment vars from top
	tlsCert, _, err := getcert.FromTLSServer("grpc.maintemplate.ci.getcouragenow.org:443", false)

	config := &tls.Config{
		Certificates: []tls.Certificate{tlsCert},
	}

	conn, err := grpc.Dial("grpc.maintemplate.ci.getcouragenow.org:443", grpc.WithTransportCredentials(credentials.NewTLS(config)))
	if err != nil {
		log.Fatalf("Couldnt connect to service: %v", err)
	}

	client = proto.NewBroadcastClient(conn)
	user := &proto.User{
		Id:   hex.EncodeToString(id[:]),
		Name: *name,
	}

	connect(user)

	wait.Add(1)
	go func() {
		defer wait.Done()

		scanner := bufio.NewScanner(os.Stdin)
		for scanner.Scan() {
			msg := &proto.Message{
				Id:        user.Id,
				Content:   scanner.Text(),
				Timestamp: timestamp.String(),
			}

			_, err := client.BroadcastMessage(context.Background(), msg)
			if err != nil {
				fmt.Printf("Error Sending Message: %v", err)
				break
			}
		}

	}()

	go func() {
		wait.Wait()
		close(done)
	}()

	<-done
}
