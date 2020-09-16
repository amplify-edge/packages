
BOILERPLATE_FSPATH=../../../boilerplate
include ${BOILERPLATE_FSPATH}/core/help.mk
include ${BOILERPLATE_FSPATH}/core/go.mk
include ${BOILERPLATE_FSPATH}/core/tool.mk

override LIB_BIN_NAME=protoc-gen-configdef

override GO_FSPATH:=${PWD}
override GO_BIN_NAME=${TOOL_PROTOC_GEN_CONFIGDEF_BIN_NAME}
override GO_BUILD_OUT_FSPATH:=${TOOL_PROTOC_GEN_CONFIGDEF_BIN_FSPATH}
override GO_BUILD_OUT_ALL_FSPATH:=${PWD}/builds

# Print
this-print:
	@echo
	@echo -- TOOL LANG --
	@echo GO_BUILD_OUT_FSPATH: 						${GO_BUILD_OUT_FSPATH}
	@echo GO_BUILD_OUT_ALL_FSPATH: 					${GO_BUILD_OUT_ALL_FSPATH}
	@echo TOOL_PROTOC_GEN_CONFIGDEF_BIN_NAME 		${TOOL_LANG_BIN_NAME}
	@echo


## Build for all platforms
this-build-all: this-clean-all
	${MAKE} go-build-all

this-clean-all:
	${MAKE} go-build-clean-all

## Build
this-build: this-clean
	${MAKE} go-build
	which ${TOOL_PROTOC_GEN_CONFIGDEF_BIN_NAME}

this-clean:
	rm -rf ${TOOL_PROTOC_GEN_CONFIGDEF_BIN_NAME}


