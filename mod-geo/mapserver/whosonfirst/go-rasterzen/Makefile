

# https://github.com/whosonfirst/go-rasterzen


LIB_NAME=go-rasterzen
LIB=github.com/whosonfirst/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)

LIB_BIN_NAME=$(LIB_NAME)
LIB_BIN_FSPATH=$(GOPATH)/bin/$(LIB_BIN_NAME)

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


print: ## print
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


go-build: ## go-build
	# into its bin
	cd $(LIB_FSPATH) && make rebuild


# https://developers.nextzen.org/keys
export NEXTZEN_APIKEY=WamxgmroS--FvYBcvVRM6A
go-run: ## go-run
	mkdir -p $(LIB_FSPATH)/./cache/
	cd $(LIB_FSPATH) && ./bin/rasterd -fs-cache -fs-root $(LIB_FSPATH)/./cache/ -nextzen-apikey $(NEXTZEN_APIKEY) -www


go-seed: ## go-seed
	#cd $(LIB_FSPATH) && 	./bin/rasterd -fs-cache -fs-root ./cache/ -nextzen-apikey {NEXTZEN_API} -www

	cd $(LIB_FSPATH) && ./bin/rasterzen-seed -fs-cache -fs-root cache -nextzen-apikey $(NEXTZEN_APIKEY) -mode extent -extent '-73.9475518701 45.4145906777 -73.4761975429 45.7037982616' -min-zoom 10 -max-zoom 12 -seed-png -www