

GO111MODULE=on

SAMPLE_NAME=example
SAMPLE_FSPATH=$(PWD)/$(SAMPLE_NAME)

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


print: ## print

	@echo
	@echo SAMPLE_NAME: $(SAMPLE_NAME)
	@echo SAMPLE_FSPATH: $(SAMPLE_FSPATH)
	@echo

### FLU

flu-fix: ## flu-fix
	# https://github.com/flutter/flutter/issues/20685

	# 1
	# open xcode
	#cd $(SAMPLE_FSPATH)/ios && open Runner.xcodeproj
	# File > Project Settings : Build System: "New Build System(Default)

	# 2
	# edit pod file to include this: https://github.com/flutter/flutter/blob/master/examples/platform_view/ios/Podfile#L78
	# Add:
	# install! 'cocoapods', :disable_input_output_paths => true
	#cd $(SAMPLE_FSPATH)/ios && code Podfile

	# 3
	#cd $(SAMPLE_FSPATH)/ios && pod install

flu-config: ## flu-config
	flutter channel beta
	flutter upgrade

flu-web-run: ## flu-web-run
	# WORKS :)
	flutter config --enable-web
	cd $(SAMPLE_FSPATH) && flutter run -d chrome

flu-web-build: ## flu-web-build
	# WORKS :)
	flutter config --enable-web
	cd $(SAMPLE_FSPATH) && flutter build web

flu-mob-run: ## flu-mob-run
	# WORKS :)
	cd $(SAMPLE_FSPATH) && flutter run -d all

flu-desk-run: ## flu-desk-run
	# WORKS :)
	##cd $(SAMPLE_FSPATH) && hover init
	cd $(SAMPLE_FSPATH) && hover run




