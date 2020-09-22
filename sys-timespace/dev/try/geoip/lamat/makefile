
GO_OS 		:= $(shell go env GOOS)
GO_ARCH		:= $(shell go env GOARCH)

GIT_VERSION	:= $(shell git describe --tags)

current_dir = $(shell pwd)


# https://github.com/FrankSantoso/lamat

LIB_NAME=lamat
LIB=github.com/FrankSantoso/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)
LIB_BIN_FSPATH=$(GOPATH)/bin/$(LIB_NAME)

GO111MODULE=on


SAMPLE_NAME = example
SAMPLE_FSPATH = $(PWD)/$(SAMPLE_NAME)

# Absolute File path to Server
SERVER_FSPATH=$(current_dir)/../server

help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf " \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

print: ## print
	@echo
	@echo GO_OS: $(GO_OS)
	@echo GO_ARCH: $(GO_ARCH)
	@echo GIT_VERSION: $(GIT_VERSION)
	
	@echo


	@echo
	@echo LIB_NAME: $(LIB_NAME)
	@echo LIB: $(LIB)
	@echo LIB_BRANCH: $(LIB_BRANCH)
	@echo LIB_FSPATH: $(LIB_FSPATH)
	@echo LIB_BIN_FSPATH: $(LIB_BIN_FSPATH)
	@echo

	@echo SAMPLE
	@echo SAMPLE_FSPATH: $(SAMPLE_FSPATH)
	@echo

	@echo I18N
	@echo I18N_TEMPLATE_PATH: $(I18N_TEMPLATE_PATH)
	@echo I18N_PREFIX_OUT_FILES: $(I18N_PREFIX_OUT_FILES)
	@echo

	@echo SERVER:
	@echo SERVER_FSPATH: $(SERVER_FSPATH)
	@echo

git-clone:
	mkdir -p $(LIB_FSPATH)
	cd $(LIB_FSPATH) && cd .. && rm -rf $(LIB_NAME) && git clone ssh://git@$(LIB).git
	cd $(LIB_FSPATH) && git checkout $(LIB_BRANCH)
git-pull:
	cd $(LIB_FSPATH) && git pull
git-clean:
	rm -rf $(LIB_FSPATH)

code:
	code $(LIB_FSPATH)



os-dep:
	# Assume hover make file has ben run

### FLU

flu-config: ## flu-config
	flutter channel beta
	flutter upgrade --force

flu-web-run: ## flu-web-run
	flutter config --enable-web
	cd $(SAMPLE_FSPATH) && flutter run -d chrome

flu-web-build: ## flu-web-build
	flutter config --enable-web
	cd $(SAMPLE_FSPATH) && flutter build web

flu-mob-run: ## flu-mob-run
	cd $(SAMPLE_FSPATH) && flutter run -d all

flu-desk-run: ## flu-desk-run
	##cd $(SAMPLE_FSPATH) && hover init
	cd $(SAMPLE_FSPATH) && hover run


### GEN 

flu-gen: ## flu-gen
	cd $(SAMPLE_FSPATH) && flutter packages get
	$(MAKE) gen-icons
	$(MAKE) gen-hive
	$(MAKE) gen-proto
	cd $(SAMPLE_FSPATH) && flutter analyze 

gen-icons:
	# mobile and web
	@echo
	@echo Generating icons for Flutter
	@echo
	cd $(SAMPLE_FSPATH) && flutter pub run flutter_launcher_icons:main

	# desktop
	@echo
	@echo Copying icon-png from flutter assets into go assets, so hover can use it
	@echo
	cp $(SAMPLE_FSPATH)/assets/icon/icon.png $(SAMPLE_FSPATH)/go/assets

gen-hive:
	cd $(SAMPLE_FSPATH) && flutter packages pub run build_runner build --delete-conflicting-outputs

gen-proto:
	pub global activate protoc_plugin
	mkdir -p $(SAMPLE_FSPATH)/lib/api/v1/google/protobuf

ifeq ($(GO_OS), windows)
	@echo Windows detected
	protoc empty.proto timestamp.proto wrappers.proto --proto_path=$(LIB_FSPATH)/server/third_party/google/protobuf/ --plugin=$(HOME_PATH)/AppData/Roaming/Pub/Cache/bin/protoc-gen-dart.bat --dart_out=grpc:"$(PROTO_OUTPUT)/client/lib/chat_view/api/v1/google/protobuf"
	protoc chat.proto --proto_path=$(LIB_FSPATH)/server/api/proto/v1/ --plugin=$(HOME_PATH)/AppData/Roaming/Pub/Cache/bin/protoc-gen-dart.bat --dart_out=grpc:"$(PROTO_OUTPUT)/client/lib/chat_view/api/v1/"
else
	protoc empty.proto timestamp.proto wrappers.proto --proto_path=$(LIB_FSPATH)/server/third_party/google/protobuf --plugin=protoc-gen-dart=$(HOME)/.pub-cache/bin/protoc-gen-dart --dart_out=grpc:$(SAMPLE_FSPATH)/lib/api/v1/google/protobuf
	protoc chat.proto --proto_path=$(LIB_FSPATH)/server/api/proto/v1/ --plugin=protoc-gen-dart=$(HOME)/.pub-cache/bin/protoc-gen-dart --dart_out=grpc:$(SAMPLE_FSPATH)/client/lib/chat_view/api/v1/
endif


## GO

## nominatim
## API registration: https://developer.mapquest.com/plan_purchase/steps/business_edition/business_edition_free/register
## Key: https://developer.mapquest.com/user/me/apps
go-config:
	stat ./config.toml

go-build:
	cd $(LIB_FSPATH)/cmd && go build -o $(LIB_BIN_FSPATH)

go-run-rev: ## go-run-rev
	# Reverse Geocoding
	# https://www.latlong.net/
	# Berlin: Lat; 52.520008, LONG: 13.404954
	#lamat rev -- 13.404954 52.520008
	lamat rev -- 52.520008 13.404954 

go-run-for: ## go-run-for
	# Forward Geocoding
	#lamat find -- "Berlin, Germany"

	# WORKS
	#lamat find -- "30 Unter den Eichen, 14478 Potsdam, DE"

	# FAILS
	lamat find -- "27 Old Gloucester Street, Monomark House, London, WC1N 3AX, GB"

	lamat find -- "27 Old Gloucester Street, London, WC1N 3AX, GB"
	# RESULT: Tutorially, 27, Old Gloucester Street, Holborn, St Giles, London Borough of Camden, London, Greater London, England, WC1N 3AX, United Kingdom

	

	

