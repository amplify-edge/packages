module github.com/winwisely112/packages/maintemplate/server

go 1.13

replace github.com/getcouragenow/packages v0.0.0-20200305101555-5048f3d4a686 => ../../..

replace github.com/winwisely112/packages v0.0.0-20200305101555-5048f3d4a686 => ../../..

replace github.com/getcouragenow/packages/mod-chat/server v0.0.0-20200305101555-5048f3d4a686 => ../../mod-chat/server

require (
	github.com/desertbit/timer v0.0.0-20180107155436-c41aec40b27f // indirect
	github.com/getcouragenow/packages/mod-chat/server v0.0.0-20200305101555-5048f3d4a686 // indirect
	github.com/gorilla/websocket v1.4.1 // indirect
	github.com/improbable-eng/grpc-web v0.12.0 // indirect
	github.com/rs/cors v1.7.0 // indirect
	golang.org/x/net v0.0.0-20200301022130-244492dfa37a
	google.golang.org/grpc v1.27.1
)
