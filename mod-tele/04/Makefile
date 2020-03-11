

# ALL VARS get overidden in your own "env.mk"

SELF_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

# Grab necessary submodules, in case the repo was cloned without --recursive
#$(SELF_DIR)/.ci/common.mk:
#	git submodule update --init --recursive

# Incldue your env.mk
include $(SELF_DIR)/env.mk


help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)


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

dep:
	# none
	brew install libvorbis openal-soft


### cloud

cloud-auth:
	gcloud auth login
	gcloud config set project $(CLOUD_PROJECT_ID)

	gcloud config set run/region europe-west1
cloud-open:
	# run
	open https://console.cloud.google.com/run?project=$(CLOUD_PROJECT_ID)
	# container
	open https://console.cloud.google.com/cloud-build/builds?project=$(CLOUD_PROJECT_ID)
	# store
	open https://console.cloud.google.com/storage/browser?project=$(CLOUD_PROJECT_ID)
cloud-build:
	echo $(CLOUD_PROJECT_ID)
	cd $(LIB_FSPATH) && gcloud builds submit --tag gcr.io/$(CLOUD_PROJECT_ID)/identicon-generator
cloud-deploy:
	cd $(LIB_FSPATH) && gcloud beta run deploy --image gcr.io/$(CLOUD_PROJECT_ID)/identicon-generator --platform managed



cloud-client-get:
	# Change to use a HTTP Request that hits the API running on the cloud
	# Request needs to be a Http Form post
	curl $(CLOUD_PROJECT_URL)/identicon/generate?name=joe1



### FLU

flu-config: ## flu-config
	flutter channel beta
	flutter upgrade --force

flu-web-run: ## flu-web-run
	flutter config --enable-web
	cd $(SAMPLE_FSPATH) && flutter create .
	cd $(SAMPLE_FSPATH) && flutter run -d chrome

flu-web-build: ## flu-web-build
	flutter config --enable-web
	cd $(SAMPLE_FSPATH) && flutter build web

flu-mob-run: ## flu-mob-run
	cd $(SAMPLE_FSPATH) && flutter run -d all

flu-desk-run: ## flu-desk-run
	cd $(SAMPLE_FSPATH) && hover init
	cd $(SAMPLE_FSPATH) && hover run