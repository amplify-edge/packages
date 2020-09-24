# This make file uses composition to keep things KISS and easy.
# In the boilerpalte make files dont do any includes, because you will create multi permutations of possibilities.

# git include
BOILERPLATE_FSPATH=./../boilerplate
include $(BOILERPLATE_FSPATH)/help.mk
include $(BOILERPLATE_FSPATH)/os.mk
include $(BOILERPLATE_FSPATH)/tool.mk
include $(BOILERPLATE_FSPATH)/go.mk
include $(BOILERPLATE_FSPATH)/flu.mk


# flu build
override FLU_SAMPLE_NAME =client
override FLU_LIB_NAME =client

# go build
override GO_FSPATH:=${PWD}/server/cmd
override GO_BIN_NAME=sys-main
override GO_BUILD_OUT_FSPATH:=${GOPATH}/bin/$(GO_BIN_NAME)
override GO_BUILD_OUT_ALL_FSPATH=${PWD}/server/assets


## Print all settings
this-print: ## print
	@echo -- REPO -- 
	@echo REPOSITORY: $(REPOSITORY)
	@echo
	

	$(MAKE) os-print

	$(MAKE) go-print
	
	$(MAKE) flu-print

	$(MAKE) flu-gen-lang-print

## Gen everything
this-gen: ##
	# Only build what maintemplate needs

	# Copy config of all subs up to me !!

	# To build or run this use example.

	# GO
	# Change to using go-generate
	cd server && go generate


	# FLU
	# Change to using go-generate
	#$(MAKE) flu-gen-all
	#$(MAKE) flu-gen-lang-all
	#$(MAKE) flu-desk-build
	#$(MAKE) flu-web-build

	
this-mod:
	cd ./server && go mod tidy

this-run:
	cd ./server/cmd and go run .
	
this-build:
	cd ./server/cmd and go build .
