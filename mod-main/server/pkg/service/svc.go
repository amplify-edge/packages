package service

import (
	"context"
	"errors"
	pb "github.com/getcouragenow/packages/mod-main/server/pkg/api"
	"github.com/getcouragenow/packages/mod-main/server/pkg/config"
	"github.com/getcouragenow/packages/mod-main/server/pkg/store/minio"
	"github.com/golang/protobuf/proto"
	glog "google.golang.org/grpc/grpclog"
	"io/ioutil"
	"log"
	"os"
	"strconv"
)

// func init() {
// 	svcLog = glog.NewLoggerV2(os.Stdout, os.Stdout, os.Stdout)
// }

type Server struct {
	store  *minio.Mstore
	logger glog.LoggerV2
}

// New creates new instance of Svc,
func New(ctx context.Context, bucketName string, logger glog.LoggerV2) (*Server, error) {
	cfg, err := config.NewCfg()
	if err != nil {
		return nil, err
	}
	store, err := minio.New(ctx, bucketName, cfg.ConnOpt)
	return &Server{
		store,
		logger,
	}, nil
}

var (
	validSupportRoles = map[int]string{
		1: "Lawyer",
	}
	validOrgIds = map[int]string{
		1: "NY State Pipeline Shutdown",
	}
)

var (
	errInvalidSupportRoleId = errors.New("selected SupportRole is invalid")
	errInvalidOrgId         = errors.New("selected Org is invalid")
)

func (s *Server) NewAnswer(ctx context.Context, newreq *pb.NewAnswerRequest) (*pb.NewAnswerResponse, error) {
	// Manual validation for both campaign/ org id and SupportRole id for now
	supRoleId, err := strconv.Atoi(newreq.SelSupportRoleId)
	if err != nil {
		return nil, errInvalidSupportRoleId
	}
	if _, ok := validSupportRoles[supRoleId]; !ok {
		return nil, errInvalidSupportRoleId
	}
	orgId, err := strconv.Atoi(newreq.SelCampaignId)
	if err != nil {
		return nil, errInvalidOrgId
	}
	if _, ok := validOrgIds[orgId]; !ok {
		return nil, errInvalidOrgId
	}
	temp, err := ioutil.TempFile("/tmp", "answers-" + newreq.Id )
	if err != nil {
		log.Fatal(err)
	}
	defer os.Remove(temp.Name())
	// name := newreq.SelCampaignId + "-" + newreq.SelSupportRoleId + "-" + newreq.Id
	name := newreq.Id
	_, err = s.store.Put(ctx, name, temp)
	if err != nil {
		return nil, err
	}
	return &pb.NewAnswerResponse{
		Success:              true,
		Id:                   name,
	}, nil
}

func (s *Server) GetAnswer(ctx context.Context, getreq *pb.AnswerIdRequest) (*pb.Answer, error) {
	var ans pb.Answer
	f, err := s.store.Open(ctx, getreq.Id)
	if err != nil {
		return nil, err
	}
	res, err := ioutil.ReadAll(f)
	if err != nil {
		return nil, err
	}
	if err := proto.Unmarshal(res, &ans); err != nil {
		return nil, err
	}
	return &ans, nil
}

func (s *Server) DeleteAnswer(ctx context.Context, delreq *pb.AnswerIdRequest) (*pb.DeleteAnswerResponse, error) {
	err := s.store.Remove(delreq.GetId())
	if err != nil {
		return nil, err
	}
	return &pb.DeleteAnswerResponse{
		Success:              true,
	}, nil
}
