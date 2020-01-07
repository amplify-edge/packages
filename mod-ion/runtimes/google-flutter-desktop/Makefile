

### Flutter Desktop

# https://medium.com/flutter-community/flutter-for-desktop-create-and-run-a-desktop-application-ebeb1604f1e0

# Must be on Flutter channel master !

LIB_NAME=flutter-desktop-embedding
LIB=github.com/google/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)

export ENABLE_FLUTTER_DESKTOP=true

print:
	@echo
	@echo LIB_NAME: $(LIB_NAME)
	@echo LIB: $(LIB)
	@echo LIB_BRANCH: $(LIB_BRANCH)
	@echo LIB_FSPATH: $(LIB_FSPATH)
	@echo

git-clone:
	# need flutter desktop :)
	mkdir -p $(LIB_FSPATH)
	cd $(LIB_FSPATH) && cd .. && rm -rf $(LIB_NAME) && git clone ssh://git@$(LIB).git
	cd $(LIB_FSPATH) && git checkout $(LIB_BRANCH)
git-pull:
	cd $(LIB_FSPATH) && git pull
git-clean:
	rm -rf $(LIB_FSPATH)

code:
	code $(LIB_FSPATH) 


### Common Shared


flu-os-dep:
	# Need master to have Google Desktop and Web available.
	flutter channel master
	flutter upgrade

flu-config-clean:
	# disable all desktop
	flutter config --no-enable-linux-desktop
	flutter config --no-enable-macos-desktop
	flutter config --no-enable-windows-desktop
	flutter config --no-enable-web

	flutter config --clear-features

flu-config-mobile: flu-config-clean

	# cache
	#flutter precache --android
	#flutter precache --ios

flu-config-web: flu-config-clean
	flutter config --enable-web

	# cache
	#flutter precache --web

flu-config-desktop: flu-config-clean
	# Configure the dekstop env
	# See: https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override

	#flutter config --enable-linux-desktop
	flutter config --enable-macos-desktop
	#flutter config --enable-windows-desktop

	# cache
	#flutter precache --macos

flu-config-print:
	flutter config
	#flutter doctor -v
	flutter devices

# Dev Tools
# This allows debugging apps
# https://flutter.dev/docs/development/tools/devtools/cli

flu-tools-dep:
	#pub global activate devtools
	flutter pub global activate devtools

flu-tools-run:
	flutter pub global run devtools

flu-tools-open:
	open http://127.0.0.1.9100


### Runners

SAMPLE=example
SAMPLE_FSPATH=$(LIB_FSPATH)/$(SAMPLE)

flu-print:
	@echo SAMPLE: $(SAMPLE)
	@echo SAMPLE_FSPATH: $(SAMPLE_FSPATH)

	$(MAKE) flu-config-print

flu-desk-run:
	# works :)
	$(MAKE) flu-config-desktop

	# example in repo.
	#cd $(LIB_FSPATH)/example && flutter clean
	cd $(SAMPLE_FSPATH) && flutter packages get

	cd $(SAMPLE_FSPATH) && flutter run --debug
	#cd $(SAMPLE_FSPATH) && flutter run --release
	#cd $(SAMPLE_FSPATH) && flutter run --profile

flu-desk-build:
	# works :)
	$(MAKE) flu-config-desktop
	cd $(SAMPLE_FSPATH) && flutter packages get
	cd $(SAMPLE_FSPATH) && flutter build macos

flu-desk-open: 
	# works :)
	open $(SAMPLE_FSPATH)/build/macos/Build/Products/Debug/Flutter\ Desktop\ Example.app

MOB_SAMPLE=example_mob
#MOB_SAMPLE=example
MOB_SAMPLE_FSPATH=$(LIB_FSPATH)/$(MOB_SAMPLE)
flu-mob-create:
	cd $(LIB_FSPATH) && flutter create example_mob

flu-mob-run:
	$(MAKE) flu-config-mobile

	# example in repo.
	#cd $(LIB_FSPATH)/example && flutter clean
	cd $(MOB_SAMPLE_FSPATH) && flutter packages get

	cd $(MOB_SAMPLE_FSPATH) && flutter run -d all
	#cd $(MOB_SAMPLE_FSPATH) && flutter run -d "iPhone 11 Pro Max "
	#cd $(MOB_SAMPLE_FSPATH) && flutter run -d "iPad (5th generation)"	
	#cd $(MOB_SAMPLE_FSPATH) && flutter run -d "Nexus 5X"



WEB_SAMPLE=example_web
#WEB_SAMPLE=example
WEB_SAMPLE_FSPATH=$(LIB_FSPATH)/$(WEB_SAMPLE)
flu-web-create:
	$(MAKE) flu-config-web

	mkdir -p $(WEB_SAMPLE_FSPATH)
	cd $(WEB_SAMPLE_FSPATH) && flutter create .


flu-web-run:
	$(MAKE) flu-config-web

	# example in repo.
	#cd $(LIB_FSPATH)/example && flutter clean
	cd $(WEB_SAMPLE_FSPATH) && flutter packages get

	cd $(WEB_SAMPLE_FSPATH) && flutter run -d chrome
flu-web-build:
	$(MAKE) flu-config-web
	cd $(WEB_SAMPLE_FSPATH) && flutter build web
	