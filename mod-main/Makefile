.PHONY: protoc

protoc: protoc-go protoc-dart

protoc-go:
	protoc -I/usr/include/google/protobuf -Iserver/api/ server/api/*.proto \
		--go_out=plugins=grpc:server/pkg/api/

protoc-dart:
	protoc -Iserver/api/ server/api/*.proto --dart_out=grpc:client/lib/api/

install-dart-dep:
	pub global activate protoc_plugin