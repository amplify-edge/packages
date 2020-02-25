.DEFAULT_GOAL       := help
VERSION             := v0.0.0
TARGET_MAX_CHAR_NUM := 20

GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

RANDTAG := $(shell head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo '')

GCP_ZONE ?= europe-west3-a
GCP_REGION ?= europe-west3

.PHONY: help build prepare flu-web-run flu-mob-run clean

## Show help
help:
	@echo ''
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


check-env:
ifndef GCP_PROJECT
	$(error define GCP_PROJECT environment variable)
endif
ifndef GCP_USER
	$(error define GCP_PROJECT environment variable)
endif

## GCP configuration
gke-setup: check-env
	@echo GKEConf
	@gcloud projects add-iam-policy-binding ${GCP_PROJECT} --member user:${GCP_USER} --role roles/iam.serviceAccountKeyAdmin
	@mkdir -p ~/.getcouragenow/
	@gcloud config set project ${GCP_PROJECT}
	@gcloud iam service-accounts create ${GCP_PROJECT}-sa
	@gcloud services enable container.googleapis.com
	@gcloud projects add-iam-policy-binding ${GCP_PROJECT} --member serviceAccount:${GCP_PROJECT}-sa@${GCP_PROJECT}.iam.gserviceaccount.com --role roles/container.admin --role roles/storage.admin
	@gcloud iam service-accounts keys create ~/.getcouragenow/${GCP_PROJECT}.json --iam-account ${GCP_PROJECT}-sa@${GCP_PROJECT}.iam.gserviceaccount.com 

## GKE cluster initialize
gke-create: check-env
	@echo GKECreate
	@gcloud container clusters create ${GCP_PROJECT} --zone ${GCP_ZONE}
	@gcloud compute addresses create ${GCP_PROJECT}-static-ip --region ${GCP_REGION}

## GKE cluster variables
gke-vars:
	@echo GKEVariables
	@echo "GKE_PROJECT: "
	@echo "\t ${GCP_PROJECT}"
	@echo "GKE_IP: " 
	@echo "\t $$(gcloud compute addresses describe ${GCP_PROJECT}-static-ip --region ${GCP_REGION} | grep "address:" | cut -d ':' -f2)"
	@echo "GKE_EMAIL: "
	@echo "\t ${GCP_PROJECT}-sa@${GCP_PROJECT}.iam.gserviceaccount.com"
	@echo "GKE_KEY: "
	@echo echo $$(cat  ~/.getcouragenow/${GCP_PROJECT}.json | base64 -w0)


## Run the code
deploy:
	@echo Running
	@eval $$(minikube -p minikube docker-env)
	@cp -rf ../client/build/web flutter/
	@docker build --tag localhost:5000/grpc-web:${RANDTAG} grpc-web/
	@docker build --tag localhost:5000/flutter-web:${RANDTAG} flutter/
	@minikube addons enable ingress
	@minikube addons enable registry
	@while [ "`kubectl get pods --namespace kube-system -l kubernetes.io/minikube-addons=registry -l actual-registry=true -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}' | cut -f1`" != "True" ]]; do echo "waiting for minkube registry" && sleep 1; done
	@docker push localhost:5000/grpc-web:${RANDTAG}
	@docker push localhost:5000/flutter-web:${RANDTAG}
	@curl -o kustomize --location https://github.com/kubernetes-sigs/kustomize/releases/download/v3.1.0/kustomize_3.1.0_linux_amd64
	@chmod u+x ./kustomize
	@touch kustomization.yaml
	@./kustomize edit add resource k8s/*
	@./kustomize edit set image "gcr.io/GCP_PROJECT/IMAGE:TAG"="localhost:5000/grpc-web:${RANDTAG}"
	@./kustomize edit set image "gcr.io/GCP_PROJECT/flutter-web-IMAGE:TAG"="localhost:5000/flutter-web:${RANDTAG}"
	@./kustomize build . | kubectl replace --force -f -
	@kubectl annotate ingress maintemplate nginx.ingress.kubernetes.io/use-regex="true"
	@rm kustomization.yaml 
	@rm -rf flutter/web ./kustomize	
