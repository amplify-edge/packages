package service

import (
	"context"
	"errors"
	pb "github.com/getcouragenow/packages/mod-main/server/pkg/api"
	"github.com/getcouragenow/packages/mod-main/server/pkg/config"
	"github.com/getcouragenow/packages/mod-main/server/pkg/store/minio"
	"github.com/golang/protobuf/proto"
	glog "google.golang.org/grpc/grpclog"
	"io"
	"io/ioutil"
	"log"
	"os"
	"strconv"
)

type Server struct {
	store  *minio.Ministore
	logger glog.LoggerV2
}

// TODO client shouldnt' know anything about minio or buckets
// New creates new instance of Svc,
func New(ctx context.Context, logger glog.LoggerV2) (*Server, error) {
	cfg, err := config.NewCfg()
	if err != nil {
		return nil, err
	}
	store, err := minio.New(ctx, cfg.ConnOpt)
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
	temp, err := ioutil.TempFile("/tmp", "answers-"+newreq.Id)
	if err != nil {
		log.Fatal(err)
	}
	defer os.Remove(temp.Name())
	name := newreq.SelCampaignId + "-" + newreq.SelSupportRoleId + "-" + newreq.Id
	// name := newreq.Id
	_, err = s.store.Put(ctx, name, temp)
	if err != nil {
		return nil, err
	}
	return &pb.NewAnswerResponse{
		Success: true,
		Id:      name,
	}, nil
}

func (s *Server) GetAnswer(ctx context.Context, getreq *pb.AnswerIdRequest) (*pb.Answer, error) {
	f, err := s.store.Open(ctx, getreq.Id)
	if err != nil {
		return nil, err
	}
	ans, err := readSeekerProto(f)
	if err != nil {
		return nil, err
	}
	return ans, nil
}

func (s *Server) DeleteAnswer(ctx context.Context, delreq *pb.AnswerIdRequest) (*pb.DeleteAnswerResponse, error) {
	err := s.store.Remove(delreq.GetId())
	if err != nil {
		return nil, err
	}
	return &pb.DeleteAnswerResponse{
		Success: true,
	}, nil
}

func (s *Server) ListAnswers(ctx context.Context, listreq *pb.ListAnswersRequest) (*pb.Answers, error) {
	var answers []*pb.Answer
	prefix := listreq.GetCampaignId() + "-" + listreq.GetSupportRoleId()
	rs, err := s.store.List(ctx, prefix)
	if err != nil {
		return nil, err
	}
	for _, f := range rs {
		ans, err := readSeekerProto(f)
		if err != nil {
			return nil, err
		}
		answers = append(answers, ans)
	}
	return &pb.Answers{Answers: answers}, nil
}

func (s *Server) GetUser(ctx context.Context, req *pb.GetUserRequest) (*pb.User, error) {
	var user pb.User
	userQuery := minio.NewSingleQuery(`
	SELECT _id AS 'id', firstName, 
	lastName, email, displayName, avatar, url, chatgroupIds, campaigns 
	from s3object WHERE _id =	
	`, req.GetId(), "user[0-9]{3}")
	resp, err := s.store.GetSingle(ctx, userQuery, "users.csv")
	if err != nil {
		return nil, err
	}
	if err := proto.Unmarshal(resp, &user); err != nil {
		return nil, err
	}
	return &user, nil
}

func (s *Server) ListUsers(ctx context.Context, _ *pb.ListUserRequest) (*pb.Users, error) {
	var users pb.Users
	usersQuery := minio.NewListQuery(`
	SELECT _id AS 'id', firstName, lastName, email, displayName,  
	avatar, url, chatgroupIds, campaign
	FROM s3object`)
	resp, err := s.store.GetMultiple(ctx, usersQuery, "users.csv")
	if err != nil {
		return nil, err
	}
	if err := proto.Unmarshal(resp, &users); err != nil {
		return nil, err
	}
	return &users, nil
}

func (s *Server) GetSupportRole(ctx context.Context, req *pb.GetSupportRoleRequest) (*pb.SupportRole, error) {
	var supportRole pb.SupportRole
	roleQuery := minio.NewSingleQuery(
		`
			GSELECT id, name, comment, mandatory, uom from s3object
			WHERE id =
		`,
		req.GetId(), "crg[0-9]{3}",
	)
	resp, err := s.store.GetSingle(ctx, roleQuery, "roles.csv")
	if err != nil {
		return nil, err
	}
	if err := proto.Unmarshal(resp, &supportRole); err != nil {
		return nil, err
	}
	return &supportRole, nil
}

func (s *Server) ListSupportRoles(ctx context.Context, req *pb.ListSupportRoleRequest) (*pb.SupportRoles, error) {
	var supportRoles pb.SupportRoles
	rolesQuery := minio.NewListQuery(
		`SELECT id, name, comment, mandatory, uom from s3object`,
	)
	resp, err := s.store.GetMultiple(ctx, rolesQuery, "roles.csv")
	if err != nil {
		return nil, err
	}
	if err := proto.Unmarshal(resp, &supportRoles); err != nil {
		return nil, err
	}
	return &supportRoles, nil
}

func (s *Server) GetCampaign(ctx context.Context, req *pb.GetCampaignRequest) (*pb.Campaign, error) {
	var campaign pb.Campaign
	campaignQuery := minio.NewSingleQuery(
		`
		SELECT campaign_id, cmaign_name AS campaign_name, logo_url, goal, crg_quantity_many, 
		crg_ids_many, already_pledged, action_time, location AS action_location, start AS min_pioneers,
		media AS min_rebels_for_media, win AS min_rebels_to_win, action_type, backing_org, category,
		contact, historical_precedents AS hist_precedents, organization, strategy, video_url, uom,
		action_length FROM s3object WHERE campaign_id = 
		`,
		req.GetId(),
		"campaign_[0-9]{3}",
	)
	resp, err := s.store.GetSingle(ctx, campaignQuery, "campaign.csv")
	if err != nil {
		return nil, err
	}
	if err := proto.Unmarshal(resp, &campaign); err != nil {
		return nil, err
	}
	return &campaign, nil
}

func (s *Server) ListCampaigns(ctx context.Context, req *pb.ListCampaignRequest) (*pb.Campaigns, error) {
	var campaigns pb.Campaigns
	campaignsQuery := minio.NewListQuery(
		`
				SELECT campaign_id, cmaign_name AS campaign_name, logo_url, goal, crg_quantity_many, 
		crg_ids_many, already_pledged, action_time, location AS action_location, start AS min_pioneers,
		media AS min_rebels_for_media, win AS min_rebels_to_win, action_type, backing_org, category,
		contact, historical_precedents AS hist_precedents, organization, strategy, video_url, uom,
		action_length FROM s3object 
		`,
	)
	resp, err := s.store.GetMultiple(ctx, campaignsQuery, "campaigns.csv")
	if err != nil {
		return nil, err
	}
	if err := proto.Unmarshal(resp, &campaigns); err != nil {
		return nil, err
	}
	return &campaigns, nil
}

func readSeekerProto(f io.ReadSeeker) (*pb.Answer, error) {
	var ans pb.Answer
	res, err := ioutil.ReadAll(f)
	if err != nil {
		return nil, err
	}
	if err := proto.Unmarshal(res, &ans); err != nil {
		return nil, err
	}
	return &ans, nil
}
