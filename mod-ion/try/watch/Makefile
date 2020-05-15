

# https://github.com/jbrady42/ion-vid

# You need ION Server runnng using docker compose first
# This allows injecting a Video into a Ion Room, which will in the UI be done like in Telegram
# - an external video using a copy paste
# - an internal video from the mod-drive


GO_OS 		:= $(shell go env GOOS)
GO_ARCH		:= $(shell go env GOARCH)

GIT_VERSION	:= $(shell git describe --tags)

DIR = $(shell pwd)


LIB_NAME=ion-vid
LIB=github.com/jbrady42/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)

LIB_BIN_NAME=$(LIB_NAME)
LIB_BIN_FSPATH=$(GOPATH)/bin/$(LIB_BIN_NAME)

# PATH to ION Code ( from Server makefile )
SERVER_FSPATH=$(GOPATH)/src/github.com/pion/ion

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
	@echo SERVER_FSPATH: $(SERVER_FSPATH)
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

# First run Ion
docker-run: ## docker-run
	cd $(SERVER_FSPATH) && docker-compose up

docker-stop: ## docker-stop
	cd $(SERVER_FSPATH) && docker-compose down

# Then open it and create a room called "1".
browser-run: ## browser-run
ifeq ($(GO_OS), windows)
	@echo Windows detected
	open http://127.0.0.1:8080/
else
	@echo Darwin detected
	open http://127.0.0.1:8080/
endif

# Then run "watch" giving it a test vieo and a ion room
go-run:
	# runs watch
	# go run . -container-path <your video file> -room <room name>
	# -ion-url IF you not running ION locally
	cd $(LIB_FSPATH) && go run . -container-path <your video file> -room 1



# connect: https://github.com/pion/ion/blob/master/sdk/flutter/example/lib/helper/ion_helper.dart#L14	

flu-web-run: ## flu-web-run
	# init
	cd $(SAMPLE_FSPATH) && flutter create .
	# run
	flutter config --enable-web
	cd $(SAMPLE_FSPATH) && flutter run -d chrome

