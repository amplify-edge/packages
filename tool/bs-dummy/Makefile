# includes
BOILERPLATE_FSPATH=./../../boilerplate

include $(BOILERPLATE_FSPATH)/help.mk
include $(BOILERPLATE_FSPATH)/tool.mk
include $(BOILERPLATE_FSPATH)/go.mk

# go build
override GO_FSPATH=${PWD}

override GO_BIN_NAME=${TOOL_DUMMY_BIN_NAME}
override GO_BUILD_OUT_FSPATH:=${TOOL_DUMMY_BIN_FSPATH}

override GO_BUILD_OUT_ALL_FSPATH=${PWD}/assets



# Print
this-print:
	@echo
	@echo -- TOOL Dummy --

	@echo GO_FSPATH 				${GO_FSPATH}
	@echo TOOL_DUMMY_BIN_NAME 		${TOOL_DUMMY_BIN_NAME}
	@echo GO_BUILD_OUT_FSPATH: 		${GO_BUILD_OUT_FSPATH}
	@echo GO_BUILD_OUT_ALL_FSPATH: 	${GO_BUILD_OUT_ALL_FSPATH}

	@echo

## Build
this-build: this-build-clean
	$(MAKE) go-build
	which ${TOOL_DUMMY_BIN_NAME}

this-build-clean:
	rm -rf ${TOOL_DUMMY_BIN_NAME}

this-test:
	@echo TODO !
