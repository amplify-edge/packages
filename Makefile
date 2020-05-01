
# This make file uses composition to keep things KISS and easy.
# In the boilerpalte make files dont do any includes, because you will create multi permutations of possibilities.



# git include
include ./boilerplate/help.mk
include ./boilerplate/os.mk
include ./boilerplate/git.mk


#export REPOSITORY=$(MAKE) git-

# remove the "v" prefix
VERSION ?= $(shell echo $(TAGGED_VERSION) | cut -c 2-)


## Print all settings
print: ## print
	@echo -- REPO -- 
	@echo REPOSITORY: $(REPOSITORY)
	@echo
	

	$(MAKE) os-print
	
	$(MAKE) git-print
	
	#$(MAKE) flu-print

	#$(MAKE) lang-print

	#$(MAKE) srv-print

## So high
high: ## high
	@echo i wanna get...
