

# https://github.com/cloudwebrtc/flutter-webrtc

# should work on desktop: https://github.com/cloudwebrtc/flutter-webrtc/pull/127

LIB_NAME=flutter-webrtc
LIB=github.com/cloudwebrtc/$(LIB_NAME)
#LIB_BRANCH=desktop
#LIB_BRANCH=flutter_web
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)


SAMPLE_NAME=example
SAMPLE_FSPATH=$(LIB_FSPATH)/$(SAMPLE_NAME)

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


print:
	@echo
	@echo LIB_NAME: $(LIB_NAME)
	@echo LIB: $(LIB)
	@echo LIB_BRANCH: $(LIB_BRANCH)
	@echo LIB_FSPATH: $(LIB_FSPATH)
	@echo

	@echo
	@echo SAMPLE_NAME: $(SAMPLE_NAME)
	@echo SAMPLE_FSPATH: $(SAMPLE_FSPATH)
	@echo

git-print:
	cd $(LIB_FSPATH) && git status
git-clone:
	mkdir -p $(LIB_FSPATH)
	cd $(LIB_FSPATH) && cd .. && rm -rf $(LIB_NAME) && git clone ssh://git@$(LIB).git
	cd $(LIB_FSPATH) && git checkout $(LIB_BRANCH)
git-pull:
	cd $(LIB_FSPATH) && git pull
git-clean:
	rm -rf $(LIB_FSPATH)

WEBRTC_WORKSPACE=$(PWD)/../webrtc.code-workspace
code:
	code $(WEBRTC_WORKSPACE)
	#code $(LIB_FSPATH)

###


flu-fix:
	# https://github.com/flutter/flutter/issues/20685

	# open xcode
	cd $(SAMPLE_FSPATH)/ios && open Runner.xcodeproj
	# File > Project Settings : Build System: "New Build System(Default)

	# edit pod file to include this: https://github.com/flutter/flutter/blob/master/examples/platform_view/ios/Podfile#L78
	# Add:
	# install! 'cocoapods', :disable_input_output_paths => true
	cd $(SAMPLE_FSPATH)/ios && code Podfile

	cd $(SAMPLE_FSPATH)/ios && pod install



### WEB

flu-web-config:
	# flutter channel ?
	#flutter channel dev
	#flutter upgrade

	flutter config --enable-web
	# turn off any desktop
	flutter config --no-enable-linux-desktop
	flutter config --no-enable-macos-desktop
	flutter config --no-enable-windows-desktop
flu-web-create: flu-web-config
	# works 
	# make sure using new dir.
	mkdir -p $(SAMPLE_FSPATH)
	cd $(SAMPLE_FSPATH) && flutter create --web .
flu-web-run: flu-web-config ## flu-web-run
	# works
	# Reload works too :)
	cd $(SAMPLE_FSPATH) && flutter run -d chrome
flu-web-build: flu-web-config ## flu-web-build
	# works :)
	cd $(SAMPLE_FSPATH) && flutter build web --release
flu-web-test: flu-web-config ## flu-web-test
	# works :)
	cd $(SAMPLE_FSPATH) && flutter test --platform=chrome

