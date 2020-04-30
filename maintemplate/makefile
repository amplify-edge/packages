
# This make file uses composition to keep things KISS and easy.
# In the boilerpalte make files dont do any includes, because you will create multi permutations of possibilities.

# git include
include ../boilerplate/help.mk
include ../boilerplate/os.mk
include ../boilerplate/git.mk

include ../boilerplate/flu.mk
include ../boilerplate/srv.mk
include ../boilerplate/lang.mk

# remove the "v" prefix
VERSION ?= $(shell echo $(TAGGED_VERSION) | cut -c 2-)


## Print all settings
print: ## print

	$(MAKE) os-print
	
	#$(MAKE) git-print
	
	$(MAKE) flu-print

	$(MAKE) lang-print

	$(MAKE) srv-print

## So high
high: ## high
	@echo i wanna get...
