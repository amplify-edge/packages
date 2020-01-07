

# https://github.com/tidwall/tile38


LIB_NAME=tile38
LIB=github.com/tidwall/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)

LIB_BIN_NAME=$(LIB_NAME)
LIB_BIN_FSPATH=$(GOPATH)/bin/$(LIB_BIN_NAME)

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


print:
	@echo
	@echo LIB_NAME: $(LIB_NAME)
	@echo LIB: $(LIB)
	@echo LIB_BRANCH: $(LIB_BRANCH)
	@echo LIB_FSPATH: $(LIB_FSPATH)

	@echo
	@echo LIB_BIN_NAME: $(LIB_BIN_NAME)
	@echo LIB_BIN_FSPATH: $(LIB_BIN_FSPATH)
	@echo

git-clone:
	# need flutter desktop :)
	mkdir -p $(LIB_FSPATH)
	cd $(LIB_FSPATH) && cd .. && rm -rf $(LIB_NAME) && git clone ssh://git@$(LIB).git
	cd $(LIB_FSPATH) && git checkout $(LIB_BRANCH)
git-pull:
	cd $(LIB_FSPATH) && git pull
git-clean:
	rm -rf $(LIB_FSPATH)

code:
	code $(LIB_FSPATH)

os-dep: ## os-dep

BIN_SERVER=$(LIB_BIN_FSPATH)-server
BIN_CLI=$(LIB_BIN_FSPATH)-cli
BIN_BENCH=$(LIB_BIN_FSPATH)-benchmark
BIN_TEST=$(LIB_BIN_FSPATH)-luamemtest
build-print:
	@echo
	@echo BIN_SERVER: $(BIN_SERVER)
	@echo BIN_CLI: $(BIN_CLI)
	@echo BIN_BENCH: $(BIN_BENCH)
	@echo BIN_TEST: $(BIN_TEST)

build:
	# into the GO BIN
	# code has its own vendoring.
	
	GO111MODULE=off go build -o $(BIN_SERVER) $(LIB_FSPATH)/cmd/tile38-server/main.go
	which $(BIN_SERVER)

	GO111MODULE=off go build -o $(BIN_CLI) $(LIB_FSPATH)/cmd/tile38-cli/main.go
	which $(BIN_CLI)

	GO111MODULE=off go build -o $(BIN_BENCH) $(LIB_FSPATH)/cmd/tile38-benchmark/main.go
	which $(BIN_BENCH)

	GO111MODULE=off go build -o $(BIN_TEST) $(LIB_FSPATH)/cmd/tile38-luamemtest/main.go
	which $(BIN_TEST)
bench:
	# run these two in different termianls
	#$(BIN_SERVER)

	#$(BIN_BENCH)

