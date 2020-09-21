module github.com/getcouragenow/getcourage-packages/mod-account/authz

go 1.13

require (
	github.com/envoyproxy/go-control-plane v0.9.5
	github.com/getcouragenow/getcourage-packages/mod-account/server/keyutils v0.0.0-00010101000000-000000000000
	github.com/gogo/googleapis v1.3.2
	github.com/square/go-jose/v3 v3.0.0-20200415055503-21f2ca25ccce
	golang.org/x/net v0.0.0-20200421231249-e086a090c8fd
	google.golang.org/genproto v0.0.0-20200420144010-e5e8543f8aeb
	google.golang.org/grpc v1.29.0
)

replace github.com/getcouragenow/getcourage-packages/mod-account/server/keyutils => ../keyutils
