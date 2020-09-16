

# includes
BOILERPLATE_FSPATH=./../../boilerplate

include $(BOILERPLATE_FSPATH)/core/help.mk
include $(BOILERPLATE_FSPATH)/core/tool.mk
include $(BOILERPLATE_FSPATH)/core/go.mk

# go build
override GO_BIN_NAME=${TOOL_PROTODOC_BIN_NAME}
override GO_BUILD_OUT_FSPATH:=${TOOL_PROTODOC_BIN_FSPATH}

override GO_BUILD_OUT_ALL_FSPATH=${PWD}/assets


# Print
this-print:
	@echo
	@echo -- TOOL ProtoDoc --
	@echo BIN_NAME: 				${GO_BIN_NAME}
	@echo GO_BUILD_OUT_FSPATH: 		${GO_BUILD_OUT_FSPATH}
	@echo GO_BUILD_OUT_ALL_FSPATH: 	${GO_BUILD_OUT_ALL_FSPATH}
	
	@echo

## Build
this-build: this-build-clean
	$(MAKE) go-build 
	which $(GO_BIN_NAME)

this-build-clean:
	rm -rf ${GO_BIN_NAME}

## Build all platforms
this-build-all: this-build-clean-all
	$(MAKE) go-build-all

this-build-clean-all:
	$(MAKE) go-build-clean-all

this-test:
	go test -v ./...

	@echo TODO - call flutter tests !!

### Examples

## Example json
this-example-run:
	# exercsie the binary
	${${GO_BIN_NAME}} protoc --doc_out=./doc --doc_opt=html,index.html proto/*.proto




