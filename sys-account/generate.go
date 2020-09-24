package main

// ============================================================================
// GO
// ============================================================================
// GRPC & Protobuf
//go:generate protoc -I./proto/v2 -I. --go_out=./server/rpc/v2/ --go-grpc_out=./server/rpc/v2 --cobra_out=./server/rpc/v2 --go_opt=paths=source_relative --go-grpc_opt=paths=source_relative --cobra_opt=paths=source_relative ./proto/v2/authn.proto ./proto/v2/users.proto

// ============================================================================
// Flutter
// ============================================================================
// GRPC & Protobuf
//go:generate protoc -I./proto/v2 -I. --dart_out=grpc:./client/lib/api/v2/ ./proto/v2/authn.proto ./proto/v2/users.proto
