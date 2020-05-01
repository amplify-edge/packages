


include ../boilerplate/help.mk
include ../boilerplate/os.mk
include ../boilerplate/env.mk
#include ../boilerplate/gitr.mk
include ../boilerplate/srv.mk
include ../boilerplate/k8.mk
include ../boilerplate/flu.mk
include ../boilerplate/lang.mk


# hard override. Can also suck in exported environment variables

override ENV_SOURCE=joe
override FLU_SAMPLE_NAME=clientXXX


## Print all settings
print: ## print

	$(MAKE) os-print

	$(MAKE) env-print

	$(MAKE) k8-print

	$(MAKE) srv-print
	
	$(MAKE) flu-print

	$(MAKE) lang-print

	

## So high
high: ## high
	@echo i wanna get...
