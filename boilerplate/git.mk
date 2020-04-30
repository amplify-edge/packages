
# git reflection
GIT_REPO_NAME=$(notdir $(shell pwd))
GIT_UPSTREAM_ORG=getcouragenow
GIT_FORK_ORG=$(shell basename $(dir $(abspath $(dir $$PWD))))

# hardcoded git
GIT_SERVER=github.com

GIT_ABS_REPO_FSPATH=$(GOPATH)/src/$(GIT_SERVER)/$(GIT_FORK_ORG)/$(GIT_REPO_NAME)

# remove the "v" prefix
GIT_VERSION ?= $(shell echo $(TAGGED_VERSION) | cut -c 2-)




## Prints the git setting
git-print: ## git-print
	@echo
	@echo -- GIT --
	@echo GIT_FORK_ORG: 			$(GIT_FORK_ORG)
	@echo GIT_UPSTREAM_ORG: 		$(GIT_UPSTREAM_ORG)
	@echo GIT_REPO_NAME: 			$(GIT_REPO_NAME)
	@echo GIT_SERVER: 				$(GIT_SERVER)
	@echo GIT_VERSION: 				$(GIT_VERSION)
	@echo GIT_ABS_REPO_FSPATH: 		$(GIT_ABS_REPO_FSPATH)
	@echo


### GIT-FORK

#See: https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/syncing-a-fork


git-upstream-open: ## git-upstream-open
	open https://$(GIT_SERVER)/$(GIT_UPSTREAM_ORG)/$(GIT_REPO_NAME).git 
	

## Opens the forked git server.
git-fork-open: ## git-fork-open
	open https://$(GIT_SERVER)/$(GIT_FORK_ORG)/$(GIT_REPO_NAME).git


## Sets up the git fork locally.
git-fork-setup: ## git-fork-setup
	# Pre: you git forked ( via web) and git cloned (via ssh)
	# add upstream repo
	git remote add upstream git://$(GIT_SERVER)/$(GIT_UPSTREAM_ORG)/$(GIT_REPO_NAME).git

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