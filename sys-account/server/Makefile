LIB=github.com/getcouragenow/packages/sys-account/server
LIB_FSPATH=$(GOPATH)/src/$(LIB)
LIB_BIN_FSPATH=$(PWD)/bin
LIB_DATA_FSPATH=$(PWD)/data
LIB_BIN=$(LIB_BIN_FSPATH)/auth-$(GO_OS)-$(GO_ARCH)


GO_LIB_FSPATH=$(LIB_FSPATH)
override GO_FSPATH=$(GO_LIB_FSPATH)
override GO_BIN_NAME=sys-account
override GO_BUILD_OUT_FSPATH=$(GO_LIB_FSPATH)/bin
override GO_BUILD_OUT_ALL_FSPATH=$(GO_LIB_FSPATH)/bin-all
override GO_PKG_LIST=./authn/delivery ./authn/pkg/auth ./authn/pkg/pass ./authn/pkg/utilities

GO_STATIC_BUILDARGS := go build -a -tags netgo -ldflags '-w -extldflags -static'

this-print:
	@echo
	@echo GO_OS : $(GO_OS)
	@echo GO_ARCH : $(GO_ARCH)
	@echo GIT_VERSION : $(GIT_VERSION)
	@echo
	@echo
	@echo LIB : $(LIB)
	@echo LIB_FSPATH : $(LIB_FSPATH)
	@echo LIB_BIN_FSPATH : $(LIB_BIN_FSPATH)
	@echo LIB_DATA_FSPATH : $(LIB_DATA_FSPATH)
	@echo LIB_BIN : $(LIB_BIN)
	@echo
	@echo
	$(MAKE) flu-print
	@echo
	$(MAKE) go-print
	@echo
	@echo

	

dep:
	git clone https://$(LIB).git $(LIB_FSPATH)
dep-delete:
	rm -rf $(LIB_FSPATH)
vscode-add:
	code --add $(LIB_FSPATH) --reuse-window


### GRPC

#evans-dep:
	#go get github.com/ktr0731/evans
	# OR
	#brew tap ktr0731/evans
	#brew install evans

#grpc-evans:
	# CLI for GRPC
	# Must have GRPC Reflection turns on in code.
	#evans repl $(LIB_FSPATH)/proto/chat_service.proto

go-gen-dep:
	# Install protoc
	# brew install protobuf

	# Install protoc-gen-go
	#go get -u -v github.com/golang/protobuf/protoc-gen-go
	go get -u -v google.golang.org/protobuf/cmd/protoc-gen-go
	go install google.golang.org/protobuf/cmd/protoc-gen-go
	stat ${GOPATH}/bin/protoc-gen-go

	# Install grpc-web
	go get -u -v github.com/improbable-eng/grpc-web/go/grpcweb

	# Install protoc-gen-go-grpc
	go get google.golang.org/grpc/cmd/protoc-gen-go-grpc
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc
	stat ${GOPATH}/bin/protoc-gen-go-grpc

	# Install protoc-gen-cobra
	go get -u -v github.com/NathanBaulch/protoc-gen-cobra
	stat ${GOPATH}/bin/protoc-gen-cobra

	# then make go-mod-tidy, to ensure the imports that the generated code uses are in te go.mod

go-mod-update:
	# force pulling modes
	cd $(GO_LIB_FSPATH) && go get -v -t -d ./...

go-mod-tidy:
	cd $(GO_LIB_FSPATH) && go mod tidy
	cd $(GO_LIB_FSPATH) && go mod verify
	cd $(GO_LIB_FSPATH) && go mod download

go-run: go-run-test-client

go-build:
	@echo Building AuthServer binary
	cd $(GO_FSPATH)/cmd/authserver/ && go build -v -o $(GO_BUILD_OUT_ALL_FSPATH)/authserver
	@echo Building AuthClient binary
	cd $(GO_FSPATH)/cmd/authclient/ && go build -v -o $(GO_BUILD_OUT_ALL_FSPATH)/authclient

go-run-test-client: go-build
	@echo testing grpc-client for login
	cd $(GO_LIB_FSPATH)/bin-all && timeout 60 ./authserver &
	cd $(GO_LIB_FSPATH)/bin-all && timeout 60 ./authclient auth-service login --email "superadmain@getcouragenow.org" --password "superadmin" --server-addr "127.0.0.1:8888"

go-test:
	@echo Running tests
	cd $(GO_FSPATH) && go test -race -v  ${GO_PKG_LIST}
