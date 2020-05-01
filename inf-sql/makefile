


include ../boilerplate/help.mk
include ../boilerplate/os.mk
include ../boilerplate/env.mk
include ../boilerplate/gitu.mk
include ../boilerplate/k8.mk

#include ../boilerplate/srv.mk
#include ../boilerplate/flu.mk
#include ../boilerplate/lang.mk


# hard override. Can also suck in exported environment variables

override ENV_SOURCE=joe
override FLU_SAMPLE_NAME=clientXXX


## Print all settings
print: ## print

	$(MAKE) os-print


	$(MAKE) env-print

	$(MAKE) k8-print


	

## So whatever
whatever: ## whatever
	@echo i wanna get...


override ENV_SOURCE=joe
override FLU_SAMPLE_NAME=clientXXX

## Get all dependencies
dep: dep-liftbridge ## dep

# https://github.com/liftbridge-io/liftbridge
override GITU_REPO_SERVER=github.com
override GITU_REPO_ORG=liftbridge-io
override GITU_REPO_NAME=liftbridge
dep-liftbridge: ## dep

	$(MAKE) gitu-print
	$(MAKE) gitu-clone-master 


