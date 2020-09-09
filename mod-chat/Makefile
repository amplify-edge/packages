# This make file uses composition to keep things KISS and easy.
# In the boilerpalte make files dont do any includes, because you will create multi permutations of possibilities.

# git include
include ../boilerplate/help.mk
include ../boilerplate/os.mk
include ../boilerplate/flu.mk
include ../boilerplate/srv.mk


override FLU_SAMPLE_NAME =client/example
override FLU_LIB_NAME =client

override SERVER_FSPATH=server


## This builds everything
this-build: ##
	$(MAKE) flu-gen-lang

## Print all settings
print: ## print
	@echo -- REPO -- 
	@echo REPOSITORY: $(REPOSITORY)
	@echo
	

	$(MAKE) os-print
	
	$(MAKE) flu-print

	$(MAKE) lang-print

	$(MAKE) srv-print
