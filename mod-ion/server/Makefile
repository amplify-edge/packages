

# https://github.com/pion/ion

GO_OS 		:= $(shell go env GOOS)
GO_ARCH		:= $(shell go env GOARCH)

GIT_VERSION	:= $(shell git describe --tags)

DIR = $(shell pwd)


LIB_NAME=ion
LIB=github.com/pion/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)

FLUTTER_LIB_NAME=ion-sdk-flutter
FLUTTER_LIB=github.com/pion/$(FLUTTER_LIB_NAME)
FLUTTER_LIB_BRANCH=master
FLUTTER_LIB_FSPATH=$(GOPATH)/src/$(FLUTTER_LIB)

LIB_BIN_NAME=$(LIB_NAME)
LIB_BIN_FSPATH=$(GOPATH)/bin/$(LIB_BIN_NAME)

# Not needed for this proj, but left for others
SAMPLE_NAME=example
SAMPLE_GOPATH=$(FLUTTER_LIB)/$(SAMPLE_NAME)
SAMPLE_FSPATH=$(FLUTTER_LIB_FSPATH)/$(SAMPLE_NAME)

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


print: ## print

	@echo
	@echo GO_OS: $(GO_OS)
	@echo GO_ARCH: $(GO_ARCH)
	@echo GIT_VERSION: $(GIT_VERSION)
	@echo DIR: $(DIR)
	@echo

	@echo
	@echo LIB_NAME: $(LIB_NAME)
	@echo LIB: $(LIB)
	@echo LIB_BRANCH: $(LIB_BRANCH)
	@echo LIB_FSPATH: $(LIB_FSPATH)
	@echo

	@echo FLUTTER_LIB_NAME: $(FLUTTER_LIB_NAME)
	@echo FLUTTER_LIB: $(FLUTTER_LIB)
	@echo FLUTTER_LIB_BRANCH: $(FLUTTER_LIB_BRANCH)
	@echo FLUTTER_LIB_FSPATH: $(FLUTTER_LIB_FSPATH)

	@echo
	@echo LIB_BIN_NAME: $(LIB_BIN_NAME)
	@echo LIB_BIN_FSPATH: $(LIB_BIN_FSPATH)
	@echo

	@echo
	@echo SAMPLE_NAME: $(SAMPLE_NAME)
	@echo SAMPLE_GOPATH: $(SAMPLE_GOPATH)
	@echo SAMPLE_FSPATH: $(SAMPLE_FSPATH)
	@echo

git-clone: ## git-clone
	mkdir -p $(LIB_FSPATH)
	cd $(LIB_FSPATH) && cd .. && rm -rf $(LIB_NAME) && git clone ssh://git@$(LIB).git
	cd $(LIB_FSPATH) && git checkout $(LIB_BRANCH)
	mkdir -p $(FLUTTER_LIB_FSPATH)
	cd $(FLUTTER_LIB_FSPATH) && cd .. && rm -rf $(FLUTTER_LIB_NAME) && git clone ssh://git@$(FLUTTER_LIB).git
	cd $(FLUTTER_LIB_FSPATH) && git checkout $(FLUTTER_LIB_BRANCH)
git-pull: ## git-pull
	cd $(LIB_FSPATH) && git pull
	cd $(FLUTTER_LIB_FSPATH) && git pull
git-clean: ## git-clean
	rm -rf $(LIB_FSPATH)
	rm -rf $(FLUTTER_LIB_FSPATH)

code: ## code
	code $(LIB_FSPATH)

docker-run: ## docker-run
	cd $(LIB_FSPATH) && docker-compose up

docker-stop: ## docker-stop
	cd $(LIB_FSPATH) && docker-compose down


browser-run: ## browser-run
ifeq ($(GO_OS), windows)
	@echo Windows detected
	open http://127.0.0.1:8080/
else
	@echo Darwin detected
	open http://127.0.0.1:8080/
endif

# connect: https://github.com/pion/ion/blob/master/sdk/flutter/example/lib/helper/ion_helper.dart#L14	

flu-web-run: ## flu-web-run
	# init
	cd $(SAMPLE_FSPATH)/scripts && sh project_tools.sh create
	# run
	cd $(SAMPLE_FSPATH) && flutter run -d chrome

