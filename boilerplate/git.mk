
# git general stuff

# hardcoded
GIT_SERVER ?= github.com
GIT_ORG_UPSTREAM ?= getcouragenow

GIT_ORG_FORK=$(shell basename $(dir $(abspath $(dir $$PWD))))


GIT_USER=$(GIT_ORG_FORK)
GIT_REPO_NAME=$(notdir $(shell pwd))

# calculated
# upstream
GIT_REPO_UPSTREAM_ABS_URL=https:///$(GIT_SERVER)/$(GIT_ORG_UPSTREAM)/$(GIT_REPO_NAME)

GIT_REPO_ABS_URL=https:///$(GIT_SERVER)/$(GIT_ORG_FORK)/$(GIT_REPO_NAME)
GIT_REPO_ABS_FSPATH=$(GOPATH)/src/$(GIT_SERVER)/$(GIT_ORG_FORK)/$(GIT_REPO_NAME)

# remove the "v" prefix
GIT_VERSION ?= $(shell echo $(TAGGED_VERSION) | cut -c 2-)




## Prints the git setting
git-print: ## git-print
	@echo
	@echo -- GIT Upstream --

	@echo GIT_ORG_UPSTREAM: 			$(GIT_ORG_UPSTREAM)
	@echo GIT_REPO_UPSTREAM_ABS_URL: 	$(GIT_REPO_UPSTREAM_ABS_URL)
	

	@echo -- GIT Fork --
	@echo GIT_ORG_FORK: 				$(GIT_ORG_FORK)
	@echo GIT_SERVER: 					$(GIT_SERVER)
	@echo GIT_USER: 					$(GIT_USER)
	@echo GIT_REPO_NAME: 				$(GIT_REPO_NAME)

	@echo ---
	@echo GIT_REPO_ABS_URL: 			$(GIT_REPO_ABS_URL)
	@echo GIT_REPO_ABS_FSPATH: 			$(GIT_REPO_ABS_FSPATH)

	@echo ---
	@echo GIT_VERSION: 					$(GIT_VERSION)
	
	@echo


### GIT-FORK

#See: https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/syncing-a-fork


git-upstream-open: ## git-upstream-open
	open https://$(GIT_SERVER)/$(GIT_ORG_UPSTREAM)/$(GIT_REPO_NAME).git 
	

## Opens the forked git server.
git-fork-open: ## git-fork-open
	open $(GIT_REPO_ABS_URL).git


## Sets up the git fork locally.
git-fork-setup: ## git-fork-setup
	# Pre: you git forked ( via web) and git cloned (via ssh)
	# add upstream repo
	git remote add upstream git://$(GIT_SERVER)/$(GIT_ORG_UPSTREAM)/$(GIT_REPO_NAME).git

## Sync upstream with your fork. Use this to make a PR.
git-fork-catchup: ## git-fork-catchup
	# This fetches the branches and their respective commits from the upstream repository.
	git fetch upstream 

	# This brings your fork's master branch into sync with the upstream repository, without losing your local changes.
	git merge upstream/master


## GIT-TAG

## Create a tag.
git-tag-create: ## git-tag-create
	# this will create a local tag on your current branch and push it to Github.

	git tag $(GIT_TAG_NAME)

	# push it up
	git push origin --tags

## Deletes a tag.
git-tag-delete: ## git-tag-delete
	# this will delete a local tag and push that to Github

	git push --delete origin $(GIT_TAG_NAME)
	git tag -d $(GIT_TAG_NAME)