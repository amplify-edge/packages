# git clone https://github.com/flutter/sentry
# https://pub.dev/packages/sentry


SAMPLE_FSPATH = sentry/example

print:
	@echo $(SAMPLE_FSPATH)

dep:
	cd $(SAMPLE_FSPATH) && flutter packages get

flu-desk-local-init: ## flu-desk-local-init
	cd $(SAMPLE_FSPATH) && hover init
	
flu-desk-local-dep: ## flu-desk-local-dep
	cd $(SAMPLE_FSPATH) && hover plugins get

flu-desk-local-run: ## flu-desk-local-run
	cd $(SAMPLE_FSPATH) && hover run

flu-web-run:
	cd $(SAMPLE_FSPATH) && flutter run -d chrome