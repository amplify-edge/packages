
# This make file uses composition to keep things KISS and easy.
# In the boilerpalte make files dont do any includes, because you will create multi permutations of possibilities.

BOILERPLATE_FSPATH=./boilerplate

include $(BOILERPLATE_FSPATH)/help.mk
include $(BOILERPLATE_FSPATH)/os.mk
include $(BOILERPLATE_FSPATH)/gitr.mk
include $(BOILERPLATE_FSPATH)/tool.mk
include $(BOILERPLATE_FSPATH)/flu.mk
include $(BOILERPLATE_FSPATH)/go.mk


# remove the "v" prefix
VERSION ?= $(shell echo $(TAGGED_VERSION) | cut -c 2-)

override FLU_SAMPLE_NAME =client
override FLU_LIB_NAME =client


## Print all settings
this-print: ## print
	
	$(MAKE) os-print
	
	$(MAKE) gitr-print
	
	$(MAKE) flu-print

	$(MAKE) flu-gen-lang-print

	$(MAKE) go-print

this-dep:
	# LOCAL DEVS: go to root make file and call this yourself to get all the tools !!!!
	# install tools
	cd ./tool && $(MAKE) this-build

## Build
this-build: this-dep
	# Does full gen and build (web)
	cd ./maintemplate && $(MAKE) this-build

this-flu-desk-build: this-dep
	# For CI. Does Big Gen !
	#cd ./maintemplate && $(MAKE) flu-gen
	cd ./maintemplate && $(MAKE) flu-desk-build

this-flu-desk-run:
	# For Local dev- Does NOT do big Gen !
	# Manaully do a make this-dep to get the goalng tools yourself.
	cd ./maintemplate && $(MAKE) flu-desk-run

	

