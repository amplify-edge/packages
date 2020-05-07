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



## Print all settings
print: ## print
	@echo -- REPO -- 
	@echo REPOSITORY: $(REPOSITORY)
	@echo
	

	$(MAKE) os-print
	
	$(MAKE) flu-print

	$(MAKE) lang-print

	$(MAKE) srv-print

## So high
high: ## high
	@echo i wanna get...
