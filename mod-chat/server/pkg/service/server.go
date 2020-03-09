package service

import (
	"encoding/json"

	"log"
	"os"

	context "golang.org/x/net/context"
	glog "google.golang.org/grpc/grpclog"

	proto "github.com/getcouragenow/packages/mod-chat/server/pkg/api"
	stan "github.com/nats-io/stan.go"
)

var grpcLog glog.LoggerV2

func init() {
	grpcLog = glog.NewLoggerV2(os.Stdout, os.Stdout, os.Stdout)
}

type Connection struct {
	stream proto.Broadcast_CreateStreamServer
	id     string
	active bool
	error  chan error
}

type Server struct {
	// Connection     []*Connection
	// NatsConnection *nats.Conn
	Conn stan.Conn
	// NatsStream     *jsm.Stream
}

func (s *Server) CreateStream(pconn *proto.Connect, stream proto.Broadcast_CreateStreamServer) error {
	// conn := &Connection{
	// 	stream: stream,
	// 	id:     pconn.User.Id,
	// 	active: true,
	// 	error:  make(chan error),
	// }

	connError := make(chan error)

	sub, err := s.Conn.Subscribe("public-chat", func(m *stan.Msg) {

		log.Printf("Sending message: %+v", m.Data)
		pm := proto.Message{}
		err := json.Unmarshal(m.Data, &pm)
		if err != nil {
			log.Print(err)
			return
		}

		if err := stream.Send(&pm); err != nil {
			log.Printf("Stream connection failed: %v", err)
			connError <- err
		}
		log.Printf("Message sent: %+v", m.Data)
	}, stan.DeliverAllAvailable(), stan.DurableName(pconn.GetUser().GetId()))

	if err != nil {
		log.Fatal(err)
	}

	defer sub.Unsubscribe()

	return <-connError
}

func (s *Server) BroadcastMessage(ctx context.Context, msg *proto.Message) (*proto.Close, error) {
	jmsg, err := json.Marshal(msg)
	if err != nil {
		log.Print(err)
	}
	s.Conn.Publish("public-chat", jmsg)
	log.Printf("Broadcast: %+v", msg)

	return &proto.Close{}, nil
}
