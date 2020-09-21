
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


## Print all settings
this-print: ## print
	
	$(MAKE) os-print
	
	$(MAKE) gitr-print

## Build
this-build:
	# Does full gen and build (web)
	cd ./maintemplate && $(MAKE) this-build

this-flu-desk-build:	
	# For CI. Does Big Gen !
	cd ./maintemplate && $(MAKE) flu-desk-build

this-flu-desk-run:
	# For Local dev- Does NOT do big Gen !
	cd ./maintemplate && $(MAKE) flu-desk-run

	

