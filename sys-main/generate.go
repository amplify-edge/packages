package main

/// GO

// GRPC
// gen the GRPC golang code for Server and CLI
//go:generate protoc -I./proto -I. --go_out=./rpc --go-grpc_out=./rpc --cobra_out=./rpc --go_opt=paths=source_relative --go-grpc_opt=paths=source_relative --cobra_opt=paths=source_relative ./proto/authn.proto

// CONFIG
// Copy to caller .

// LANG
// not sure yet what will might need here.

// DATA
// generate the test data with faker

/// FLU

// GRPC
// $(MAKE) flu-gen-proto
// gen the GRPC flutter code for GRPC and GRPCWeb

// LANG
// $(MAKE) flu-gen-lang-clean
// $(MAKE) flu-gen-lang
// $(MAKE) flu-gen-lang-dart
// $(MAKE) flu-gen-lang-submodules

// ICONS
// $(MAKE) gen-icons

// CACHE ( later )
// $(MAKE) gen-hive ( hive-cache )
