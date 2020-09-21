package main

//go:generate protoc -I./proto -I. --go_out=./rpc --go-grpc_out=./rpc --cobra_out=./rpc --go_opt=paths=source_relative --go-grpc_opt=paths=source_relative --cobra_opt=paths=source_relative ./proto/authn.proto
