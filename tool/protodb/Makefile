# includes
BOILERPLATE_FSPATH=./../../boilerplate

include $(BOILERPLATE_FSPATH)/core/help.mk
include $(BOILERPLATE_FSPATH)/core/tool.mk
include $(BOILERPLATE_FSPATH)/core/go.mk


# go build
override GO_FSPATH:=${PWD}
override GO_BUILD_OUT_FSPATH:=${TOOL_PROTODB_BIN_FSPATH}
GO_BUILD_OUT_BIN_NAME:= ${TOOL_PROTODB_BIN_NAME}

# Print
this-print:
	@echo
	@echo -- TOOL DUMMY --
	@echo GO_BUILD_OUT_FSPATH: ${GO_BUILD_OUT_FSPATH}
	@echo GO_BUILD_OUT_BIN_NAME ${GO_BUILD_OUT_BIN_NAME}
	@echo

## Build
this-build: this-build-clean
	## WW99: BROKEN and will fix once other fires out...
	#$(MAKE) go-build 
	#which ${GO_BUILD_OUT_BIN_NAME}

this-build-clean:
	rm -rf ${GO_BUILD_OUT_BIN_NAME}

this-test:
	@echo TODO







