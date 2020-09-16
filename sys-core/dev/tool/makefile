# grpc tools

# This puts everything onto the global path.
# Assumes you have Golang installed.
# Assumes you are on a MAC.


# Found from : https://github.com/lynxkite/lynxkite/blob/master/sphynx/proto_compile.sh

# Envoy
LIB_ENVOY=						github.com/tetratelabs/getenvoy
LIB_ENVOY_REPO_FSPATH=			$(GOPATH)/src/$(LIB_ENVOY)
LIB_ENVOY_GETENVOY_VERSION= 	v0.1.8
LIB_ENVOY_VERSION= 				standard:1.14.3

# grpcui is a golang Web GUI for GRPC
# https://github.com/fullstorydev/grpcui
LIB_GRPCUI_REPO=				github.com/fullstorydev/grpcui
LIB_GRPCUI_REPO_FSPATH=			$(GOPATH)/src/$(LIB_GRPCUI_REPO)

# GO GRPC is now here:https://github.com/grpc/grpc-go
LIB_GRPC_REPO=					github.com/grpc/grpc-go
LIB_GRPC_REPO_FSPATH=			$(GOPATH)/src/$(LIB_GRPC_REPO)

# New
# https://github.com/protocolbuffers/protobuf-go
# which is https://godoc.org/google.golang.org/protobuf/cmd/protoc-gen-go
LIB_PB_REPO=					github.com/protocolbuffers/protobuf-go
LIB_PB_REPO_FSPATH=				$(GOPATH)/src/$(LIB_PB_REPO)

# Old ( last update in 14 May, 2020, so very old )
# https://github.com/golang/protobuf/
LIB_PBOLD_REPO=					github.com/golang/protobuf
LIB_PBOLD_REPO_FSPATH=			$(GOPATH)/src/$(LIB_PBOLD_REPO)

# grpc-gateway & swagger
# https://github.com/grpc-ecosystem/grpc-gateway
# has github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
# has github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
LIB_GRPC_GATEWAY_REPO=			github.com/grpc-ecosystem/grpc-gateway
LIB_GRPC_GATEWAY_REPO_FSPATH=	$(GOPATH)/src/$(LIB_GRPC_GATEWAY_REPO)
LIB_GRPC_GATEWAY_REPO_VERSION=	v1.14.6 # NOT USED 

# Protoc
# All tags here: https://github.com/protocolbuffers/protobuf/tags
# For now just using Brew. Will upgrade to use a golang downloader soon.
LIB_PROTOC_VERSION=				NONE

# help

# Note assumes AWK is installed

.DEFAULT_GOAL       := help
HELP_TARGET_MAX_CHAR_NUM := 20

HELP_GREEN  := $(shell tput -Txterm setaf 2)
HELP_YELLOW := $(shell tput -Txterm setaf 3)
HELP_WHITE  := $(shell tput -Txterm setaf 7)
HELP_RESET  := $(shell tput -Txterm sgr0)


# Print help
help:

	@echo ''
	@echo 'Usage:'
	@echo '  ${HELP_YELLOW}make${HELP_RESET} ${HELP_GREEN}<target>${HELP_RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${HELP_YELLOW}%-$(HELP_TARGET_MAX_CHAR_NUM)s${HELP_RESET} ${HELP_GREEN}%s${HELP_RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## Print
grpc-print:
	@echo
	@echo -- Envoy --
	@echo LIB_ENVOY_REPO_FSPATH: 		$(LIB_ENVOY_REPO_FSPATH)
	@echo LIB_ENVOY_GETENVOY_VERSION: 	$(LIB_ENVOY_GETENVOY_VERSION)
	@echo LIB_ENVOY_VERSION: 			$(LIB_ENVOY_VERSION)

	@echo
	@echo -- GRPCUI GUI --
	@echo LIB_GRPCUI_REPO_FSPATH: 		$(LIB_GRPCUI_REPO_FSPATH)

	@echo
	@echo -- GO GRPC compiler --
	@echo LIB_GRPC_REPO_FSPATH: 		$(LIB_GRPC_REPO_FSPATH)

	@echo
	@echo -- GO Protobuf compiler --
	@echo LIB_PB_REPO_FSPATH: 			$(LIB_PB_REPO_FSPATH)

	@echo
	@echo -- OLD Golang Protobuf compiler --
	@echo LIB_PBOLD_REPO_FSPATH: 		$(LIB_PBOLD_REPO_FSPATH)

	@echo
	@echo -- GO GRPC Gateway compiler --
	@echo LIB_GRPC_GATEWAY_REPO_FSPATH: $(LIB_GRPC_GATEWAY_REPO_FSPATH)

	@echo
	@echo -- Protoc compiler --
	@echo LIB_PROTOC_VERSION: 			$(LIB_PROTOC_VERSION)

	@echo

## All
grpc-all:
	$(MAKE) grpc-all-git-delete
	$(MAKE) grpc-all-git-clone
	$(MAKE) grpc-all-build
	$(MAKE) grpc-which

## Which
grpc-which:
	@echo
	@echo -- envoy --
	@which envoy
	@envoy --version
	@echo

	@echo -- grpcli --
	@which grpc_cli
	@echo

	@echo
	@echo -- grpcui -- 
	@which grpcui
	@grpcui -version
	@echo

	@echo
	@echo -- protoc --
	@which protoc
	protoc --version
	@echo

	@echo
	@echo -- protoc-gen-go --
	@which protoc-gen-go
	@protoc-gen-go --version
	@echo

	@echo
	@echo -- protoc-gen-grpc-gateway --
	@which protoc-gen-grpc-gateway
	
	@echo
	@echo -- protoc-gen-swagger --
	@which protoc-gen-swagger

	@echo
	@echo -- protoc-gen-go-grpc --
	@which protoc-gen-go-grpc

	@echo


## All-git-clone
grpc-all-git-clone:
	# Envoy
	# See: https://github.com/pomerium/pomerium/blob/master/Makefile
	# this installs the getter into the GOBIN
	GO111MODULE=on go get $(LIB_ENVOY)/cmd/getenvoy@${LIB_ENVOY_GETENVOY_VERSION}

	# GRPC
	git clone https://$(LIB_GRPC_REPO) $(LIB_GRPC_REPO_FSPATH)

	# GRPCUI
	git clone https://$(LIB_GRPCUI_REPO) $(LIB_GRPCUI_REPO_FSPATH)

	# New golang protobuf compiler
	git clone https://$(LIB_PB_REPO) $(LIB_PB_REPO_FSPATH)

	# OLD golang protobuf compiler
	git clone https://$(LIB_PBOLD_REPO) $(LIB_PBOLD_REPO_FSPATH)

	# GRPC Gateway compiler
	git clone https://$(LIB_GRPC_GATEWAY_REPO) $(LIB_GRPC_GATEWAY_REPO_FSPATH)

## All-git-delete
grpc-all-git-delete:
	rm -rf $(LIB_ENVOY_REPO_FSPATH)
	rm -rf $(LIB_GRPCUI_REPO_FSPATH)
	rm -rf $(LIB_GRPC_REPO_FSPATH)
	rm -rf $(LIB_PB_REPO_FSPATH)
	rm -rf $(LIB_PBOLD_REPO_FSPATH)
	rm -rf $(LIB_GRPC_GATEWAY_REPO_FSPATH)

grpc-all-vscode-add:
	code --add $(LIB_ENVOY_REPO_FSPATH) --reuse-window
	code --add $(LIB_GRPCUI_REPO_FSPATH) --reuse-window
	code --add $(LIB_GRPC_REPO_FSPATH) --reuse-window
	code --add $(LIB_PB_REPO_FSPATH) --reuse-window
	code --add $(LIB_PBOLD_REPO_FSPATH) --reuse-window
	code --add $(LIB_GRPC_GATEWAY_REPO_FSPATH) --reuse-window

## All-build
grpc-all-build: grpc-envoy-build grpc-grpcli-build grpc-grpcui-build grpc-pb-build

## All-delete
grpc-all-delete: grpc-envoy-delete grpc-grpcli-delete grpc-grpcui-delete grpc-pb-delete


### ENVOY

## Envyo-build
grpc-envoy-build:
	@echo
	@echo -- Start: Envoy build --
	@echo

	# this pulls down envoy to /usr/local/bin
	getenvoy fetch $(LIB_ENVOY_VERSION)
	# copy it to GOBIN.
	cp -f /usr/local/bin/envoy $(GOPATH)/bin/envoy

	@echo
	@echo -- End: Envoy build --
	@echo

grpc-envoy-delete:
	@echo
	@echo -- Start: Envoy Delete --
	@echo

	rm -rf $(GOPATH)/bin/envoy



### GRPC CLI
grpc-grpcli-build:

	@echo
	@echo -- Start: grpccli build --
	@echo

	# grpc_cli tool to call the GRPC from command line, and do basic smoke tests
	# REPO: https://github.com/grpc/grpc/blob/master/doc/command_line_tool.md
	# Examples: https://medium.com/@at_ishikawa/use-grpc-cli-to-request-a-grpc-server-37219b33c94b
	# Is works by using Reflection: https://github.com/grpc/grpc-go/blob/master/Documentation/server-reflection-tutorial.md
	brew install grpc

	@echo
	@echo -- End: grpccli build --
	@echo

grpc-grpcli-delete:
	@echo
	@echo -- Start: GRPCLI Delete --
	@echo

	# grpc_cli
	brew uninstall grpc

### GRPCUI
grpc-grpcui-build:
	@echo
	@echo -- Start: GRPCUI build --
	@echo

	# instal to GOBIN
	cd $(LIB_GRPCUI_REPO_FSPATH)/cmd/grpcui && go install .

	@echo
	@echo -- End: GRPCUI build --
	@echo

grpc-grpcui-delete:
	@echo
	@echo -- Start: GRPCUI Delete --
	@echo

	rm -f $(GOPATH)/bin/grpcui


### Protoc basis

# Download and put into GOPATH also

grpc-protoc-build:
	@echo
	@echo -- protoc --

	# Protoc that is the basis
	brew install protobuf

grpc-protoc-delete:
	brew uninstall protobuf


### GO Protobuf generators 

grpc-pb-build: grpc-protoc-build
	@echo
	@echo -- Start: Golang PB build --
	@echo

	# Golang PB
	cd $(LIB_PB_REPO_FSPATH)/cmd/protoc-gen-go && go install .

	# Golang GRPC
	cd $(LIB_GRPC_REPO_FSPATH)/cmd/protoc-gen-go-grpc && go install .

	# Golang GRPC Gatway
	cd $(LIB_GRPC_GATEWAY_REPO_FSPATH)/protoc-gen-grpc-gateway && go install .

	# Golang Swagger
	cd $(LIB_GRPC_GATEWAY_REPO_FSPATH)/protoc-gen-swagger && go install .

	# Dart GRPC and Protobuf
	# NOT git cloned, but installed by Dart itself for Latest. If we hit probs then we can version it.
	# Assumes dart installed 
	pub global activate protoc_plugin

	@echo
	@echo -- End: Golang PB build --
	@echo

grpc-pb-delete: grpc-protoc-delete
	@echo
	@echo -- Start: Golang PB Delete --
	@echo

	rm -f $(GOPATH)/bin/protoc-gen-go
	rm -f $(GOPATH)/bin/protoc-gen-go-grpc
	rm -f $(GOPATH)/bin/protoc-gen-grpc-gateway
	rm -f $(GOPATH)/bin/protoc-gen-swagger
	
	



### Old GO Protobuf generators
	
grpc-pbold-build: grpc-protoc-build
	@echo
	@echo -- Start: Golang PB-OLD build --
	@echo

	cd $(LIB_PBOLD_REPO_FSPATH)/protoc-gen-go && go install .


	@echo
	@echo -- End: Golang PB-OLD build --
	@echo

grpc-pbold-delete: grpc-protoc-delete
	@echo
	@echo -- Start: Golang PB-OLD Delete --
	@echo

	rm -f $(GOPATH)/bin/protoc-gen-go


export PROTO_SOURCE_DIR="proto"
export PROTO_SOURCE_FILE="sphynx.proto"
grpc-gen:
	@echo Generating Protos
	# Generate the gRPC Go interfaces using NEW compiler

	protoc ${PROTO_SOURCE_DIR}/${PROTO_SOURCE_FILE} --go-grpc_out=proto --go_out=proto
