package main

import (
	"encoding/json"
	"flag"
	"io/ioutil"
	"log"
	"net/http"
	"strings"

	proto "github.com/getcouragenow/packages/mod-chat/server/pkg/api"

	"github.com/nats-io/stan.go"
)

var (
	channel    string
	file       string
	clusterID  string
	clientID   string
	stanClient stan.Conn
)

func main() {
	flag.StringVar(&channel, "channel", "public-chat", "channel to add fake data")
	flag.StringVar(&clusterID, "cluster-id", "test-cluster", "nats streaming server cluster id")
	flag.StringVar(&clientID, "client-id", "test-client-2", "nats streaming server client id")
	flag.StringVar(&file, "file", "../fake_data/data.json", "file fake data could be simple file or url")
	flag.Parse()

	sc, err := stan.Connect(clusterID, clientID)
	if err != nil {
		log.Fatalf("Can't connect: %v.\nMake sure a NATS Streaming Server is running at: %s", err)
	}

	defer sc.Close()
	stanClient = sc
	populate(file, true)
}

func openFileFomURL(url string) ([]byte, error) {
	res, err := http.Get(url)
	if err != nil {
		return nil, err
	}
	defer res.Body.Close()
	return ioutil.ReadAll(res.Body)
}

// populate
func populate(file string, local bool) error {

	var data []byte
	var err error
	if strings.HasPrefix(file, "http") {
		data, err = openFileFomURL(file)
	} else {
		data, err = ioutil.ReadFile(file)
	}

	messages := []proto.Message{}
	err = json.Unmarshal(data, &messages)
	if err != nil {
		return err
	}

	for _, msg := range messages {
		data, err := json.Marshal(msg)
		if err != nil {
			continue
		}
		err = stanClient.Publish(channel, data)
		if err != nil {
			log.Println(err.Error())
		}
	}
	stan.DefaultOptions.NatsConn.Flush()
	return nil
}
