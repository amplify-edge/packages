module github.com/winwisely112/packages/mod-chat/server

replace github.com/getcouragenow/packages/mod-chat/server v0.0.0-20200305101555-5048f3d4a686 => ./

replace github.com/winwisely112/packages/mod-chat/server v0.0.0-20200303070444-8d0e769db653 => ./

go 1.13

require (
	github.com/getcouragenow/packages/mod-chat/server v0.0.0-20200305101555-5048f3d4a686 // indirect
	github.com/golang/protobuf v1.3.2
	github.com/nats-io/stan.go v0.6.0 // indirect
	google.golang.org/grpc v1.27.1
)
