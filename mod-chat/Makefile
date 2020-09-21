# includes
BOILERPLATE_FSPATH=./../boilerplate

include $(BOILERPLATE_FSPATH)/help.mk
include $(BOILERPLATE_FSPATH)/os.mk
include $(BOILERPLATE_FSPATH)/tool.mk
include $(BOILERPLATE_FSPATH)/go.mk
include $(BOILERPLATE_FSPATH)/flu.mk


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

	$(MAKE) go-print
	
	$(MAKE) flu-print

	$(MAKE) lang-print

	