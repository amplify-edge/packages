
# git
REPO_NAME=$(notdir $(shell pwd))
UPSTREAM_ORG=getcouragenow
FORK_ORG=$(shell basename $(dir $(abspath $(dir $$PWD))))

# remove the "v" prefix
VERSION ?= $(shell echo $(TAGGED_VERSION) | cut -c 2-)

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


print:
	@echo
	@echo FORK_ORG: $(FORK_ORG)

	@echo UPSTREAM_ORG: $(UPSTREAM_ORG)
	@echo REPO_NAME: $(REPO_NAME)
	@echo


### GIT-FORK

#See: https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/syncing-a-fork


git-upstream-open: ## git-upstream-open
	open https://github.com/$(UPSTREAM_ORG)/$(REPO_NAME).git 
	


git-fork-open: ## git-fork-open
	open https://github.com/$(FORK_ORG)/$(REPO_NAME).git

git-status:
	git status

git-fork-setup: ## git-fork-setup
	# Pre: you git forked ( via web) and git cloned (via ssh)
	# add upstream repo
	git remote add upstream git://github.com/$(UPSTREAM_ORG)/$(REPO_NAME).git

git-fork-catchup: ## git-fork-catchup
	# This fetches the branches and their respective commits from the upstream repository.
	git fetch upstream 

	# This brings your fork's master branch into sync with the upstream repository, without losing your local changes.
	git merge upstream/master


## GIT-TAG

git-tag-create: ## git-tag-create
	# this will create a local tag on your current branch and push it to Github.

	git tag $(TAG_NAME)

	# push it up
	git push origin --tags

git-tag-delete: ## git-tag-delete
	# this will delete a local tag and push that to Github

	git push --delete origin $(TAG_NAME)
	git tag -d $(TAG_NAME)