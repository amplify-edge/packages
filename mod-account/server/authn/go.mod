module github.com/getcouragenow/getcourage-packages/mod-account/authn

go 1.13

require (
	github.com/getcouragenow/getcourage-packages/mod-account/server/keyutils v0.0.0-00010101000000-000000000000
	github.com/golang/protobuf v1.4.0-rc.4.0.20200313231945-b860323f09d0
	github.com/gorilla/securecookie v1.1.1
	github.com/grpc-ecosystem/go-grpc-middleware v1.2.0
	github.com/hashicorp/go-uuid v1.0.2
	golang.org/x/crypto v0.0.0-20190911031432-227b76d455e7
	google.golang.org/grpc v1.29.0
	google.golang.org/protobuf v1.21.0
)

replace github.com/getcouragenow/getcourage-packages/mod-account/server/keyutils => ../keyutils
