# Check that it works recursively so from Main and all improted modules get hit
# Then its just a matter of making the code in internal/box into a bs-embed binary that gets called

# https://github.com/koddr/example-embed-static-files-go/issues/1
# - at gen time gen a golang constants fiel that can be used in the app to get the files.



# includes
BOILERPLATE_FSPATH=./../../boilerplate

include $(BOILERPLATE_FSPATH)/help.mk
include $(BOILERPLATE_FSPATH)/tool.mk
include $(BOILERPLATE_FSPATH)/go.mk


# go build
override GO_FSPATH:=${PWD}

override GO_BIN_NAME=${TOOL_BOX_BIN_NAME}
override GO_BUILD_OUT_FSPATH:=${TOOL_BOX_BIN_FSPATH}

override GO_BUILD_OUT_ALL_FSPATH=${PWD}/assets

# Print
this-print:
	@echo
	@echo -- TOOL LANG --
	@echo GO_FSPATH 				${GO_FSPATH}
	@echo GO_BIN_NAME 				${GO_BIN_NAME}
	@echo GO_BUILD_OUT_FSPATH: 		${GO_BUILD_OUT_FSPATH}
	@echo GO_BUILD_OUT_ALL_FSPATH: 	${GO_BUILD_OUT_ALL_FSPATH}
	@echo

this-dep:
	go get github.com/securego/gosec/v2/cmd/gosec

## Fixed so mod
this-mod:
	$(MAKE) go-mod-update

## Build
this-build: this-build-clean
	$(MAKE) go-build 
	which ${GO_BIN_NAME}

this-build-clean:
	rm -f ${GO_BUILD_OUT_FSPATH}


this-test:
	go test -v ./...

	@echo TODO - call flutter tests !!

## Build Example
this-ex-build:
	cd mod01 && $(MAKE) build
	cd maintemplate && $(MAKE) build

## Run Example
this-ex-run:
	cd maintemplate && $(MAKE) run

