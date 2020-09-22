# This make file uses composition to keep things KISS and easy.
# In the boilerpalte make files dont do any includes, because you will create multi permutations of possibilities.

# git include
BOILERPLATE_FSPATH=./../boilerplate
include $(BOILERPLATE_FSPATH)/help.mk
include $(BOILERPLATE_FSPATH)/os.mk
include $(BOILERPLATE_FSPATH)/tool.mk
include $(BOILERPLATE_FSPATH)/go.mk
include $(BOILERPLATE_FSPATH)/flu.mk



override FLU_SAMPLE_NAME =client/example
override FLU_LIB_NAME =client


## Print all settings
this-print: ## print
	@echo -- REPO -- 
	@echo REPOSITORY: $(REPOSITORY)
	@echo
	

	$(MAKE) os-print

	$(MAKE) go-print
	
	$(MAKE) flu-print

	$(MAKE) flu-gen-lang-print

	

## This builds everything
this-build: ##
	$(MAKE) flu-gen-lang


