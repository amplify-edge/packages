# https://github.com/joe-getcouragenow/gomessenger

# fork: github.com/joe-getcouragenow/gomessenger
# WOrks
# Chat App with GRPC go backend demo.

# git include
BOILERPLATE_FSPATH=./../../boilerplate
include $(BOILERPLATE_FSPATH)/help.mk
include $(BOILERPLATE_FSPATH)/os.mk
include $(BOILERPLATE_FSPATH)/gitr.mk
include $(BOILERPLATE_FSPATH)/go.mk


LIB=github.com/getcouragenow/packages/sys-account/server
LIB_FSPATH=$(GOPATH)/src/$(LIB)
LIB_BIN_FSPATH=$(PWD)/bin
LIB_DATA_FSPATH=$(PWD)/data
LIB_BIN=$(LIB_BIN_FSPATH)/gomessenger-$(GO_OS)-$(GO_ARCH)


GO_LIB_FSPATH=$(LIB_FSPATH)
override GO_FSPATH=$(GO_LIB_FSPATH)/cmd
override GO_BIN_NAME=sys-account
override GO_BUILD_OUT_FSPATH=$(GO_LIB_FSPATH)/bin
override GO_BUILD_OUT_ALL_FSPATH=$(GO_LIB_FSPATH)/bin-all
override GO_PKG_LIST=.

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

evans-dep:
	#go get github.com/ktr0731/evans
	# OR
	brew tap ktr0731/evans
	brew install evans

grpc-evans:
	# CLI for GRPC
	# Must have GRPC Reflection turns on in code.
	evans repl $(LIB_FSPATH)/proto/chat_service.proto

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

	# then make go-gen, to gen the grpc code.

	# then make go-mod-tidy, to ensure the imports that the generated code uses are in te go.mod

go-gen:
	# gen runs from the go folder so that the same go.mod is used for gen and run.
	mkdir -p $(GO_LIB_FSPATH)/rpc
	cd $(GO_LIB_FSPATH) && go generate

go-mod-update:
	# force pulling modes
	cd $(LIB_FSPATH)/gms-go && go get -v -t -d ./...

go-mod-tidy:
	cd $(LIB_FSPATH)/gms-go && go mod tidy
	cd $(LIB_FSPATH)/gms-go && go mod verify
	cd $(LIB_FSPATH)/gms-go && go mod download

