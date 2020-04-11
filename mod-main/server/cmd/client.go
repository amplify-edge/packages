package main

import (
	"context"
	"crypto/tls"
	"flag"
	pb "github.com/getcouragenow/packages/mod-main/server/pkg/api"
	"time"

	// pb "github.com/getcouragenow/packages/mod-main/server/pkg/api"
	"github.com/johnsiilver/getcert"
	"github.com/joho/godotenv"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
	"log"
)

var (
	envFile = flag.String("c", "./env.sample", "path to config file")
)

func main() {
	flag.Parse()
	err := godotenv.Load(*envFile)
	if err != nil {
		log.Fatalf("Couldn't open config file: %v", err)
	}

	tlsCert, _, err := getcert.FromTLSServer("grpc.maintemplate.ci.getcouragenow.org:443", false)

	config := &tls.Config{
		Certificates: []tls.Certificate{tlsCert},
	}
	conn, err := grpc.Dial(
		"grpc.maintemplate.ci.getcouragenow.org:443",
		grpc.WithTransportCredentials(credentials.NewTLS(config)))
	if err != nil {
		log.Fatalf("Couldnt connect to service: %v", err)
	}
	defer conn.Close()
	
	c := pb.NewQuestionClient(conn)

	ctx, cancel := context.WithTimeout(context.Background(), 8*time.Second)
	defer cancel()
	
	_, err = c.NewAnswer(ctx, &pb.NewAnswerRequest{
		Id:                   "ThisIsFirstOne",
		SelSupportRoleId:     "1",
		SelCampaignId:        "1",
		MinHoursPledged:      "5",
	})
	if err != nil {
		log.Fatalf("Error while creating new answer: %v", err)
	}
	
	ans, err := c.GetAnswer(ctx, &pb.AnswerIdRequest{Id: "1"})
	if err != nil {
		log.Fatalf("Error while getting answer: %v", err)
	}
	
	log.Printf("Got: %v", ans)
}
