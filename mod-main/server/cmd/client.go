package main

import (
	"context"
	"crypto/tls"
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"time"

	pb "github.com/getcouragenow/packages/mod-main/server/pkg/api"
	"github.com/johnsiilver/getcert"

	// pb "github.com/getcouragenow/packages/mod-main/server/pkg/api"
	"log"

	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
)

// TODO extend for env vars needed
// Env vars should be in the k8s deployment (i.e. helm charts via secrets)

func main() {
	// printTestDataFiles()
	local := flag.Bool("local", true, "connect with local server")

	var conn *grpc.ClientConn
	var err error
	if *local {
		// Connect with local server
		conn, err = grpc.Dial("127.0.0.1:8081", grpc.WithInsecure())
		if err != nil {
			log.Fatalf("Couldnt connect to service: %v", err)
		}
	} else {
		// Connect with remote server
		tlsCert, _, err := getcert.FromTLSServer("grpc.maintemplate.ci.getcouragenow.org:443", false)
		if err != nil {
			log.Fatalf("Couldnt get tlsCert: %v", err)
		}

		config := &tls.Config{
			Certificates: []tls.Certificate{tlsCert},
		}
		conn, err = grpc.Dial("grpc.maintemplate.ci.getcouragenow.org:443",
			grpc.WithTransportCredentials(credentials.NewTLS(config)))
	}

	defer conn.Close()

	c := pb.NewQuestionClient(conn)

	ctx, cancel := context.WithTimeout(context.Background(), 8*time.Second)
	defer cancel()

	// Migrate csv's to minio
	_, err = c.Migrate(ctx, &pb.MigrateRequest{Datapath: "data/outputs/datadump/"})
	if err != nil {
		log.Fatalf("Error while creating new answer: %v", err)
	}

	campaings, err := c.ListCampaigns(ctx, &pb.ListCampaignRequest{})
	if err != nil {
		log.Fatalf("Error while getting answer: %v", err)
	}
	log.Println("----------------All Campaigns---------------------")
	log.Println(campaings)
	log.Printf("-------------------------------------")

	campaing, err := c.GetCampaign(ctx, &pb.GetCampaignRequest{Id: "campaign_001"})
	if err != nil {
		log.Fatalf("Error while getting answer: %v", err)
	}
	log.Println("----------------Campaign ID 001---------------------")
	log.Println(campaing)
	log.Printf("-------------------------------------")

	supRol, err := c.GetSupportRole(context.Background(),
		&pb.GetSupportRoleRequest{Id: "crg001"})
	if err != nil {
		log.Fatalf("Error while getting roles: %v", err)
	}

	log.Println("----------------All Supported Role id crg001---------------------")
	log.Println(supRol)
	log.Printf("-------------------------------------")

	roles, err := c.ListSupportRoles(context.Background(), &pb.ListSupportRoleRequest{})
	if err != nil {
		log.Fatalf("Error while getting answer: %v", err)
	}

	log.Println("----------------All Supported Roles---------------------")
	log.Println(roles)
	log.Printf("-------------------------------------")

	user, err := c.GetUser(context.Background(), &pb.GetUserRequest{Id: "user001"})
	if err != nil {
		log.Fatalf("Error while getting user: %v", err)
	}
	log.Println("----------------user id 001---------------------")
	log.Println(user)
	log.Printf("-------------------------------------")

	users, err := c.ListUsers(context.Background(), &pb.ListUserRequest{})
	if err != nil {
		log.Fatalf("Error while getting users: %v", err)
	}
	log.Println("----------------All users---------------------")
	log.Println(users)
	log.Printf("-------------------------------------")
}

func printTestDataFiles() {
	var files []string

	root := "../data/outputs/datadump/"
	err := filepath.Walk(root, func(path string, info os.FileInfo, err error) error {
		files = append(files, path)
		return nil
	})
	if err != nil {
		panic(err)
	}
	for _, file := range files {
		fmt.Println(file)
	}
}
