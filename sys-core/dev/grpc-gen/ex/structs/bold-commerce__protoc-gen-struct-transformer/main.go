package main

import (
	"context"
	"fmt"

	"github.com/bold-commerce/protoc-gen-struct-transformer/example/model"
	"github.com/bold-commerce/protoc-gen-struct-transformer/example/transform"
)

func main() {

	p := model.Product{
		ID:                001,
		Name:              "name",
		One:               "one",
		SecondID:          "secondid",
		CustomField:       "custom_field",
		CustomOneof:       "custom_oneof",
		NotsupportedOneof: "notsupported_oneof",
	}

	fmt.Println(p)

}

func (s *server) CreateProduct(ctx context.Context, req *pb.Request) (*pb.Response, error) {
	p, err := s.svc.Create(ctx, transform.PbToProduct(req.Product))
	if err != nil {
		return nil, err
	}

	return &pb.Response{
		Product: transform.ProductToPb(p),
	}, nil
}
