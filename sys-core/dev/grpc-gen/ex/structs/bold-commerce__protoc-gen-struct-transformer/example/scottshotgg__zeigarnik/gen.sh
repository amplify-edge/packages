#!/bin/bash

cd docs/proto

# Look at: https://github.com/danielvladco/go-proto-gql

DOCS_DIR=../../docs

protoc \
  -I . \
  --go_out=Moptions/annotations.proto=github.com/bold-commerce/protoc-gen-struct-transformer/options,plugins=grpc:../../pkg \
  --struct-transformer_out=package=transform,helper-package=helpers,goimports=true:../../pkg/types \
  --grpc-gateway_out=logtostderr=true:../../pkg \
  --swagger_out=logtostderr=true:../../docs/swagger \
  --graphql_out=:../../pkg \
  *.proto