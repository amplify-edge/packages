

# git include
BOILERPLATE_FSPATH=./../boilerplate
include $(BOILERPLATE_FSPATH)/help.mk
include $(BOILERPLATE_FSPATH)/os.mk
include $(BOILERPLATE_FSPATH)/tool.mk
include $(BOILERPLATE_FSPATH)/flu.mk
include $(BOILERPLATE_FSPATH)/go.mk

override FLU_SAMPLE_NAME =client
override FLU_LIB_NAME =client

## Print all settings
this-print: ## print

	$(MAKE) os-print
	
	$(MAKE) flu-print

	$(MAKE) flu-gen-lang-print

	$(MAKE) go-print

## This builds everything
this-build: ##
	$(MAKE) flu-gen-lang
	$(MAKE) flu-gen-lang-dart

## This builds maintemplate and all submodules
this-build-all: ##
	$(MAKE) this-build
	# COMENTED OUT stuff we dont need for v2
	#cd ../mod-account && make this-build
	#cd ../mod-chat && make this-build
	cd ../mod-main && make this-build
	#cd ../mod-geo && make this-build
	#cd ../mod-chat && make this-build
	#cd ../mod-write && make this-build
	#cd ../mod-ion && make this-build
	#cd ../mod-kanban && make this-build



