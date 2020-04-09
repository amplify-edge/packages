

# https://github.com/cloudwebrtc/flutter-webrtc-server

GO_OS 		:= $(shell go env GOOS)
GO_ARCH		:= $(shell go env GOARCH)

GIT_VERSION	:= $(shell git describe --tags)

DIR = $(shell pwd)


LIB_NAME=flutter-webrtc-server
LIB=github.com/cloudwebrtc/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)

LIB_BIN_NAME=$(LIB_NAME)
LIB_BIN_FSPATH=$(GOPATH)/bin/$(LIB_BIN_NAME)

# Not needed for this proj, but left for others
SAMPLE_NAME=
SAMPLE_GOPATH=$(LIB)/$(SAMPLE_NAME)
SAMPLE_FSPATH=$(LIB_FSPATH)/$(SAMPLE_NAME)

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
git-pull: ## git-pull
	cd $(LIB_FSPATH) && git pull
git-clean: ## git-clean
	rm -rf $(LIB_FSPATH)

code: ## code
	code $(LIB_FSPATH)

go-build:
ifeq ($(GO_OS), windows)
	@echo Windows detected
	cd $(LIB_FSPATH) && $(MAKE) windows
else
	@echo Darwin detected
	cd $(LIB_FSPATH) && $(MAKE) darwin
endif

go-run:
ifeq ($(GO_OS), windows)
	@echo Windows detected
	cd $(LIB_FSPATH) && bin/server-windows-amd64.exe
else
	@echo Darwin detected
	cd $(LIB_FSPATH) && bin/server-darwin-amd64
endif

	