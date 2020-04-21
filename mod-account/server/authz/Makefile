.DEFAULT_GOAL       := help
VERSION             := v0.0.0
TARGET_MAX_CHAR_NUM := 20

GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

RANDTAG := $(shell head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo '')

KEYRING_NAME ?= authz_keyring
KEY_NAME ?= authz_key_$(uuidgen -t)
KMS_REGION ?= global

#.PHONY: help build prepare flu-web-run flu-mob-run clean

## Show help
help:
	@echo 'Server for ext-authz'
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## Pull down gsheets data
get-data:
	@echo ''
	@echo '$(YELLOW)IF THE CONFIGS CANNOT BE FOUND, MAKE SURE TO RUN $(WHITE)make build$(YELLOW) IN THE $(WHITE)boostrap/tools/i18n$(YELLOW) [github.com/getcouragenow/bootstrap]'
	@echo ''
	@echo 'If there are many 403 errors you may have ran into the google api limiter, check the output folder before assuming nothing made it through$(RESET)'
	@echo ''
	@mkdir -p ./data/config
	@echo "*" > ./data/.gitignore
	@cp ${GOPATH}/config/i18n/datadumpconfig.yml ./data/config/datadumpconfig.yml
	@cd data && ${GOPATH}/bin/i18n gsheet -o datadump

## Removes data folder and all of it's contents
del-data:
	@if [ -f ./data ]; then rm -r ./data; fi
	@echo '${GREEN}Data Removed${RESET}'
	@echo 'Run ${YELLOW}make get-data${RESET} to regenerate the data'

## Generate keypair (public and private) in json format
gen-keys: gen-secrets
	@echo '${GREEN}generating keys based on Ed25519${RESET}'
#	@kubectl apply -f keys/keypair-secrets.yaml

gen-secrets:
	go run cmd/jwtkey/jwtkey.go -a ECC -p keys

encrypt-secrets:
	@gcloud kms encrypt --location=${KMS_REGION} \
		--keyring=${KEYRING_NAME} \
		--key=${KEY_NAME} \
		--ciphertext-file=keys/keypair-secrets.yaml \
		--plaint


## Run unit tests on keyutil library
run-unit-tests:
	@echo '${GREEN}Running unit tests{RESET}'
	go test -v pkg/keyutil/*_test.go

## Generate sample jwt token
create-jwt-token:
	@echo '${YELLOW}ONLY IN DEVELOPMENT${RESET}'
	@echo '${GREEN} generating sample jwt token${RESET}'
	go run cmd/claims/claims.go -a ECC -k ./keys/jwk-sigs-private.json

## Cloud-KMS setup
init-kms:
	@echo '${YELLOW}Make sure both GCP_PROJECT and GCP_USER env is valid${RESET}'
	@echo '${YELLOW}and `gcloud init` is correctly setup${RESET}'
	# Create key-ring
	@gcloud kms keyrings create ${KEYRING_NAME} --location global
	@gcloud kms keys create ${KEY_NAME} --location  global --keyring ${KEYRING_NAME} --purpose encryption --project $(gcloud config get-value project)
	@gcloud kms keys add-iam-policy-binding ${KEY_NAME} --location ${KMS_REGION} \
		--keyring ${KEYRING_NAME} --member serviceAccount:${GCP_USER} \
		--role roles/cloudkms.cryptoKeyEncrypterDecrypter \
		--project ${GCP_PROJECT}
