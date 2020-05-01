


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


## Get all dependencies
dep: dep-liftbridge ## dep

# https://github.com/liftbridge-io/liftbridge
override GITU_REPO_SERVER=github.com
override GITU_REPO_ORG=liftbridge-io
override GITU_REPO_NAME=liftbridge
MY_VAR := $(MAKE) gitu-getfspath
dep-liftbridge:

	$(MAKE) gitu-print

	@echo MY_VAR $(MY_VAR)

	#$(MAKE) gitu-clone-master 

	

lift-run:
	cd $(MAKE) 


