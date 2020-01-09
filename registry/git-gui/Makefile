# https://github.com/pd4d10/git-touch

# My Fork: https://github.com/winwisely99/git-touch

# TODO: Support Gitea: https://github.com/pd4d10/git-touch/issues/5
# Add Project Screen using https://github.com/PonnamKarthik/FlutterTrelloCards
# - gitea support hit.
# Server: https://github.com/go-gitea/gitea
# API: https://gitea.com/gitea/go-sdk (old: https://github.com/go-gitea/go-sdk)



# NOTE: This git structure is setup to pull ours and upstream from other locations outside the main project code
# This is an approach that allows us to manage the large number of project dependencies we have.
# Googles Fuchsia jire can also do this but yet to adopt.

## change this for each dev- THis uses a ssh config overide
LIB_GIT_ORG				= github.com-winwisely99
LIB_GIT_ORG_UPSTREAM	= github.com
LIB_GIT_REPO			= winwisely99/git-touch
LIB_GIT_REPO_UPSTREAM	= pd4d10/git-touch
LIB_GIT_URL				= $(LIB_GIT_ORG):$(LIB_GIT_REPO).git
LIB_GIT_URL_UPSTREAM	= $(LIB_GIT_ORG_UPSTREAM):$(LIB_GIT_REPO_UPSTREAM).git

SAMPLE_FSPATH 	= git-touch

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


print:
	@echo
	@echo LIB
	@echo LIB_GIT_ORG: 		$(LIB_GIT_ORG)
	@echo LIB_GIT_REPO: 	$(LIB_GIT_REPO)
	@echo LIB_GIT_URL: 		$(LIB_GIT_URL)
	@echo

	@echo
	@echo LIB UPSTREAM
	@echo LIB_GIT_ORG_UPSTREAM: 	$(LIB_GIT_ORG_UPSTREAM)
	@echo LIB_GIT_REPO_UPSTREAM: 	$(LIB_GIT_REPO_UPSTREAM)
	@echo LIB_GIT_URL_UPSTREAM: 	$(LIB_GIT_URL_UPSTREAM)
	@echo

	@echo
	@echo SAMPLE_FSPATH:	$(SAMPLE_FSPATH)
	@echo

### GIT
git-clone: ## git-clone
	git clone git@$(LIB_GIT_URL)

git-clone-upstream: ## git-clone
	mkdir -p upstream
	cd upstream && git clone git@$(LIB_GIT_URL_UPSTREAM)



## GO

go-dep:	## go-dep
	# TODO: gitea stuff

### FLU

flu-dep: ## flu-dep
	cd $(SAMPLE_FSPATH) && pub get

flu-gen: ## flu-dep
	# gen things
	cd $(SAMPLE_FSPATH) && flutter pub run build_runner build

### DESK

flu-desk-init: ## flu-desk-init
	cd $(SAMPLE_FSPATH) && hover init
	
flu-desk-dep: ## flu-desk-dep
	cd $(SAMPLE_FSPATH) && hover plugins get

flu-desk-run: ## flu-desk-run
	
	cd $(SAMPLE_FSPATH) && hover run

### WEB
flu-web-run: ## flu-web-run
	cd $(SAMPLE_FSPATH) && flutter run -d chrome