# https://github.com/jhomlala/catcher


SAMPLE_FSPATH = catcher/example

print:
	@echo $(SAMPLE_FSPATH)

flu-desk-local-init: ## flu-desk-local-init
	cd $(SAMPLE_FSPATH) && hover init
	
flu-desk-local-dep: ## flu-desk-local-dep
	cd $(SAMPLE_FSPATH) && hover plugins get

flu-desk-local-run: ## flu-desk-local-run
	
	cd $(SAMPLE_FSPATH) && hover run

flu-web-run:
	cd $(SAMPLE_FSPATH) && flutter run -d chrome