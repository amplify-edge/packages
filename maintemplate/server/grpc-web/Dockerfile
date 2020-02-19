FROM golang:1.13-alpine as builder
RUN apk --no-cache add git

RUN go get -d \
    github.com/pkg/errors \
    golang.org/x/net/context \
    google.golang.org/grpc \
    github.com/golang/protobuf/ptypes

WORKDIR /go/src/github.com/winwisely112/flutter-grpc-tutorial/go-server
COPY . .

RUN go build -o app cmd/server/main.go

# --- Execution Stage

FROM alpine:latest
EXPOSE 9074/tcp

WORKDIR /root/
COPY --from=builder /go/src/github.com/winwisely112/flutter-grpc-tutorial/go-server/app .

ENTRYPOINT ["./app"]
