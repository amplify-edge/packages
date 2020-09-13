# NOTE: DO NOT USE YET -  Work in progress !!

# This make file uses composition to keep things KISS and easy.
# In the boilerpalte make files dont do any includes, because you will create multi permutations of possibilities.



# git include
include ../boilerplate/help.mk
include ../boilerplate/os.mk
include ../boilerplate/flu.mk
include ../boilerplate/srv.mk

override FLU_SAMPLE_NAME =client
override FLU_LIB_NAME =client

## This builds everything
this-build: ##
	$(MAKE) flu-gen-lang
	$(MAKE) flu-gen-lang-dart

## This builds maintemplate and all submodules
this-build-all: ##
	$(MAKE) this-build
	cd ../mod-account && make this-build
	cd ../mod-chat && make this-build
	cd ../mod-main && make this-build
	cd ../mod-geo && make this-build
	cd ../mod-chat && make this-build
	cd ../mod-write && make this-build
	cd ../mod-ion && make this-build
	cd ../mod-kanban && make this-build

## Print all settings
print: ## print

	$(MAKE) os-print
	
	$(MAKE) flu-print

	$(MAKE) lang-print

	$(MAKE) srv-print

