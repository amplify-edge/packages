# includes
BOILERPLATE_FSPATH=./../boilerplate

include $(BOILERPLATE_FSPATH)/help.mk
include $(BOILERPLATE_FSPATH)/os.mk
include $(BOILERPLATE_FSPATH)/tool.mk
include $(BOILERPLATE_FSPATH)/go.mk
include $(BOILERPLATE_FSPATH)/flu.mk

# flu build
override FLU_SAMPLE_NAME =client/example
override FLU_LIB_NAME =client

# go build
override GO_FSPATH:=${PWD}/server/cmd/server
override GO_BIN_NAME=sys-core
override GO_BUILD_OUT_FSPATH:=${GOPATH}/bin/$(GO_BIN_NAME)
override GO_BUILD_OUT_ALL_FSPATH=${PWD}/server/assets

## Print all settings
this-print: ## print

	$(MAKE) os-print

	$(MAKE) go-print
	
	$(MAKE) flu-print

	$(MAKE) flu-gen-lang-print

	


this-dep:
	
	@echo -- DEP ALL: start --

	@echo -- DEP ALL: finish --	

this-gen:

	@echo -- GEN ALL: start --


	@echo -- GEN ALL: finish --	


# CI and local call this
## Build everything
this-build: this-dep this-gen

	@echo -- BUILD ALL: start --

	$(MAKE) go-build

	@echo -- BUILD ALL: finish --


this-build-all:
	## TODO: Build all like we do in core-bs


## For DEVS

this-go-run:
	$(MAKE) go-run

this-flu-run:
	# runs the example so you can test sys-core in isolation.
	$(MAKE) flu-desk-run


