
UPSTREAM_ORG=getcouragenow
REPO_NAME=packages

CWD=$(PWD)


print:
	@echo
	@echo CWD: $(CWD)

	@echo UPSTREAM_ORG: $(UPSTREAM_ORG)
	@echo REPO_NAME: $(REPO_NAME)
	@echo


#See: https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/syncing-a-fork

git-status:
	git status

git-fork-setup:
	# Pre: you git forked ( via web) and git cloned (via ssh)
	# add upstream repo
	git remote add upstream git://github.com/$(UPSTREAM_ORG)/$(REPO_NAME).git

git-fork-catchup:
	# This fetches the branches and their respective commits from the upstream repository.
	git fetch upstream 

	# This brings your fork's master branch into sync with the upstream repository, without losing your local changes.
	git merge upstream/master