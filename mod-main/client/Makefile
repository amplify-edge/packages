
GO_OS 		:= $(shell go env GOOS)
GO_ARCH		:= $(shell go env GOARCH)

GIT_VERSION	:= $(shell git describe --tags)

current_dir = $(shell pwd)

SAMPLE_FSPATH = $(PWD)/example

I18N_DIR = $(current_dir)/lib/core/i18n
I18N_TEMPLATE_DIR = $(I18N_DIR)/generated
I18N_TEMPLATE_NAME = intl_messages.arb
I18N_TEMPLATE_PATH = $(I18N_TEMPLATE_DIR)/$(I18N_TEMPLATE_NAME)
I18N_PREFIX_OUT_FILES = lang

help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf " \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


print: ## print
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
	# WORKS :)
	flutter config --enable-web
	cd $(SAMPLE_FSPATH) && flutter create .
	cd $(SAMPLE_FSPATH) && flutter run -d chrome

flu-web-build: ## flu-web-build
	# WORKS :)
	flutter config --enable-web
	cd $(SAMPLE_FSPATH) && flutter build web

flu-mob-run: ## flu-mob-run
	# WORKS :)
	cd $(SAMPLE_FSPATH) && flutter run -d all

flu-desk-run: ## flu-desk-run

	#cd $(SAMPLE_FSPATH) && hover init
	cd $(SAMPLE_FSPATH) && hover run


# gen

flu-update:
	cd $(SAMPLE_FSPATH) && flutter packages get
	$(MAKE) gen-icons
	$(MAKE) gen-hive
	$(MAKE) gen-proto
	cd $(SAMPLE_FSPATH) && flutter analyze 


### GEN 

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

	# The code below is just example.

ifeq ($(GO_OS), windows)
	@echo Windows detected
	protoc empty.proto timestamp.proto wrappers.proto --proto_path=$(LIB_FSPATH)/server/third_party/google/protobuf/ --plugin=$(HOME_PATH)/AppData/Roaming/Pub/Cache/bin/protoc-gen-dart.bat --dart_out=grpc:"$(PROTO_OUTPUT)/client/lib/chat_view/api/v1/google/protobuf"
	protoc chat.proto --proto_path=$(LIB_FSPATH)/server/api/proto/v1/ --plugin=$(HOME_PATH)/AppData/Roaming/Pub/Cache/bin/protoc-gen-dart.bat --dart_out=grpc:"$(PROTO_OUTPUT)/client/lib/chat_view/api/v1/"
else
	protoc empty.proto timestamp.proto wrappers.proto --proto_path=$(LIB_FSPATH)/server/third_party/google/protobuf --plugin=protoc-gen-dart=$(HOME)/.pub-cache/bin/protoc-gen-dart --dart_out=grpc:$(SAMPLE_FSPATH)/lib/api/v1/google/protobuf
	protoc chat.proto --proto_path=$(LIB_FSPATH)/server/api/proto/v1/ --plugin=protoc-gen-dart=$(HOME)/.pub-cache/bin/protoc-gen-dart --dart_out=grpc:$(SAMPLE_FSPATH)/client/lib/chat_view/api/v1/
endif


## LANG
# 0. make lang-dep => ensure you have the i18n tool
# 1. make lang-gen-flu => generate all files

lang-dep: ## lang-dep
	go get -u github.com/getcouragenow/bootstrap/tool/i18n

# If you want the .dart files generated, add this to the bottom of the command
#flutter pub run intl_translation:generate_from_arb --output-dir=$(I18N_TEMPLATE_DIR) $(I18N_DIR)/mod_main_localization.dart $(I18N_TEMPLATE_DIR)/*.arb
lang-gen-flu: ## lang-gen-flu
	@mkdir -p $(I18N_TEMPLATE_DIR)
	@flutter pub run intl_translation:extract_to_arb --output-dir=$(I18N_TEMPLATE_DIR) $(I18N_DIR)/mod_main_localization.dart
	@i18n flutter --dir $(I18N_TEMPLATE_DIR) --template $(I18N_TEMPLATE_PATH) --prefix $(I18N_PREFIX_OUT_FILES) --languages en,fr,es,ur -f
	@i18n flutter --dir $(I18N_TEMPLATE_DIR)