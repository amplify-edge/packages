# git include
BOILERPLATE_FSPATH=./../boilerplate
include $(BOILERPLATE_FSPATH)/help.mk
include $(BOILERPLATE_FSPATH)/os.mk
include $(BOILERPLATE_FSPATH)/tool.mk
include $(BOILERPLATE_FSPATH)/flu.mk
include $(BOILERPLATE_FSPATH)/go.mk


override FLU_SAMPLE_NAME =client/example
override FLU_LIB_NAME =client


## Print all settings
this-print: ## print
	@echo -- REPO -- 
	@echo REPOSITORY: $(REPOSITORY)
	@echo

	$(MAKE) os-print
	
	$(MAKE) flu-print

	$(MAKE) flu-gen-lang-print

	#$(MAKE) srv-print

## This builds everything
this-build: ##
	$(MAKE) flu-gen-lang
