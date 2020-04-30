
# includes
include boilerplate/help.mk
include boilerplate/git.mk

# remove the "v" prefix
#VERSION ?= $(shell echo $(TAGGED_VERSION) | cut -c 2-)




print: ## print

	$(MAKE) git-print


