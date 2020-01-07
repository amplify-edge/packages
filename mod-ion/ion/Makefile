

# https://github.com/pion/ion
# https://github.com/cloudwebrtc/ion

LIB_NAME=ion
LIB=github.com/pion/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)


BIN_NAME=$(LIB_NAME)
BIN_FSPATH=$(GOPATH)/bin/$(BIN_NAME)


export ENABLE_FLUTTER_DESKTOP=true

GO_OS 		:= $(shell go env GOOS)
GO_ARCH		:= $(shell go env GOARCH)

GIT_VERSION	:= $(shell git describe --tags)

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


print: ##print
	@echo
	@echo GO_OS: $(GO_OS)
	@echo GO_OS: $(GO_ARCH)
	@echo

	@echo
	@echo GIT_VERSION: $(GIT_VERSION)
	@echo GIT_OTHER: $(shell git describe --all)
	@echo

	@echo
	@echo LIB_NAME: $(LIB_NAME)
	@echo LIB: $(LIB)
	@echo LIB_BRANCH: $(LIB_BRANCH)
	@echo LIB_FSPATH: $(LIB_FSPATH)
	@echo

	@echo
	@echo BIN_NAME: $(BIN_NAME)
	@echo BIN_FSPATH: $(BIN_FSPATH)
	@echo


os-dep: ##os-dep

	@echo Installing OS required tools

ifeq ($(GO_OS), linux)
	@echo Linux detected

	# mkcert needs:
	sudo apt install libnss3-tools
endif

ifeq ($(GO_OS), darwin)
	@echo Mac detected

	# mkcert needs:
	brew install nss
endif

ifeq ($(GO_OS), windows)
	@echo Windows detected
	# mkcert needs nothing i think. Need Windows Dev to try.
endif



docker-build: ##docker-build
	go get -u github.com/FiloSottile/mkcert
	mkcert -install
	mkcert 127.0.0.1

ifeq ($(ion), cloudwebrtc)
	mv 127.0.0.1-key.pem ./cloudwebrtc/key.pem
	mv 127.0.0.1.pem  ./cloudwebrtc/cert.pem
	
	cd ./cloudwebrtc && sudo docker-compose up	
else
	mv 127.0.0.1-key.pem ./pion/key.pem
	mv 127.0.0.1.pem ./pion/cert.pem 

	cd ./pion && sudo docker-compose up
endif

# https://github.com/pion/ion
git-clone: ##git-clone
	# need flutter desktop :)
	mkdir -p $(LIB_FSPATH)
	cd $(LIB_FSPATH) && cd .. && rm -rf $(LIB_NAME) && git clone ssh://git@$(LIB).git
	cd $(LIB_FSPATH) && git checkout $(LIB_BRANCH)
	cp -r ./pion/. $(LIB_FSPATH)

git-pull:
	cd $(LIB_FSPATH) && git pull

git-clean: ##git-clean
	rm -rf $(LIB_FSPATH)

# https://github.com/cloudwebrtc/ion
git-clone-fork: ##git-clone-fork
	# need flutter desktop :)
	mkdir -p $(LIB_FSPATH_FORKED)
	cd $(LIB_FSPATH_FORKED) && cd .. && rm -rf $(LIB_NAME) && git clone ssh://git@$(LIB_FORKED).git
	cd $(LIB_FSPATH_FORKED) && git checkout $(LIB_BRANCH)
	cp -r ./cloudwebrtc/. $(LIB_FSPATH_FORKED)
	
git-pull-fork:
	cd $(LIB_FSPATH_FORKED) && git pull

git-clean-fork: ##git-clean-fork
	rm -rf $(LIB_FSPATH_FORKED)

code:
	code $(LIB_FSPATH) 


### go
go-init:
	cd $(LIB_FSPATH)/scripts && chmod +x *.sh
	$(LIB_FSPATH)/scripts/makeKey.sh

go-build:
	cd $(LIB_FSPATH) && go build -o $(BIN_FSPATH) .

go-run:
	$(BIN_FSPATH) -h

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
	flutter precache --android
	flutter precache --ios

flu-config-web: flu-config-clean
	flutter config --enable-web

	# cache
	flutter precache --web

flu-config-desktop: flu-config-clean
	# Configure the dekstop env
	# See: https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override

	#flutter config --enable-linux-desktop
	flutter config --enable-macos-desktop
	#flutter config --enable-windows-desktop

	# cache
	flutter precache --macos

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
	