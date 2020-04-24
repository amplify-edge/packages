.DEFAULT_GOAL       := help
VERSION             := v0.0.0
TARGET_MAX_CHAR_NUM := 20

GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)


GCP_ZONE ?= europe-west3-a
GCP_REGION ?= europe-west3
MAX_NODES ?= 15

MINIKUBE_VMDRIVER :=
ifeq ($(OS),Windows_NT)
    MINIKUBE_VMDRIVER += virtualbox
else
    OSNAME := $(shell uname -s)
    ifeq ($(OSNAME), Linux)
        MINIKUBE_VMDRIVER += kvm2
    else ifeq ($(OSNAME), Darwin)
        MINIKUBE_VMDRIVER += hyperkit
    endif
endif

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

## print
print:
	@echo GCP_PROJECT: 	$(GCP_PROJECT)
	@echo GCP_USER: 	$(GCP_USER)
	@echo GCP_ZONE: 	$(GCP_ZONE)
	@echo GCP_REGION: 	$(GCP_REGION)

## gcloud-print
gcloud-print:
	gcloud config configurations list

## gcloud-print
gcloud-set:
	gcloud config configurations activate $(GCP_PROJECT)

check-env:
ifndef GCP_PROJECT
	$(error define GCP_PROJECT environment variable)
endif
ifndef GCP_USER
	$(error define GCP_USER environment variable)
endif

## GCP configuration
gke-setup: check-env
	@echo GKEConf
	@gcloud projects add-iam-policy-binding ${GCP_PROJECT} --member user:${GCP_USER} --role roles/iam.serviceAccountKeyAdmin
	#mkdir -p ~/.getcouragenow/
	mkdir -p ${HOME}/.${GCP_PROJECT}
	@gcloud config set project ${GCP_PROJECT}
	@gcloud iam service-accounts create ${GCP_PROJECT}-sa
	@gcloud services enable container.googleapis.com
	@gcloud projects add-iam-policy-binding ${GCP_PROJECT} --member serviceAccount:${GCP_PROJECT}-sa@${GCP_PROJECT}.iam.gserviceaccount.com --role roles/container.admin
	@gcloud projects add-iam-policy-binding ${GCP_PROJECT} --member serviceAccount:${GCP_PROJECT}-sa@${GCP_PROJECT}.iam.gserviceaccount.com --role roles/storage.admin
	@gcloud iam service-accounts keys create ~/.getcouragenow/${GCP_PROJECT}.json --iam-account ${GCP_PROJECT}-sa@${GCP_PROJECT}.iam.gserviceaccount.com 

## GKE cluster initialize
gke-create: check-env
	@echo GKECreate
	@gcloud container clusters create ${GCP_PROJECT} --zone ${GCP_ZONE} --enable-autoscaling --max-nodes ${MAX_NODES} 
	@gcloud compute addresses create ${GCP_PROJECT}-static-ip --region ${GCP_REGION}


## GKE resize
gke-resize:
ifndef GCP_PROJECT
	$(error define GCP_PROJECT environment variable)
endif
ifndef GCP_NODES_NUM
	$(error define GCP_NODES_NUM environment variable)
endif
	@gcloud container clusters resize ${GCP_PROJECT} --node-pool default-pool --num-nodes ${GCP_NODES_NUM} --zone ${GCP_ZONE}

## GKE destroy
gke-destroy:
ifndef GCP_PROJECT
	$(error define GCP_PROJECT environment variable)
endif
	@gcloud container clusters delete ${GCP_PROJECT}


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

## quick fixes for ci error on issue
gke-clean-services:
	@kubectl delete service ci-flutter
	@kubectl delete service ci-envoy
	@kubectl delete service ci-maintemplate

## Configure minikube vm-driver
minikube-config: 
	minikube config set vm-driver ${MINIKUBE_VMDRIVER}
	$(MAKE) minikube-clean

minikube-clean:
	minikube delete
	minikube start

## Configure minikube
minikube-init:
	@echo Running
	@minikube addons enable ingress
	@minikube addons enable registry
	@kubectl port-forward --namespace kube-system svc/registry --address localhost 5000:80	

## Deploy on minikube
minikube-deploy:
	@cp -rf ../client/build/web flutter/
	@docker build --tag localhost:5000/grpc-web grpc-web/
	@docker build --tag localhost:5000/flutter-web flutter/
	@docker push localhost:5000/grpc-web
	@docker push localhost:5000/flutter-web
	@curl -o kustomize --location https://github.com/kubernetes-sigs/kustomize/releases/download/v3.1.0/kustomize_3.1.0_linux_amd64
	@chmod u+x ./kustomize
	@touch kustomization.yaml
	@./kustomize edit add resource k8s/*
	@./kustomize edit set image "gcr.io/GKE_PROJECT/IMAGE"="localhost:5000/grpc-web"
	@./kustomize edit set image "gcr.io/GKE_PROJECT/flutter-web-IMAGE"="localhost:5000/flutter-web"
	@./kustomize build . | kubectl replace --force -f -
	@rm kustomization.yaml 
	@rm -rf flutter/web ./kustomize

## Generate app secrets
gen-app-secrets:
	@go run cmd/appsecret/appsecret.go -o ${PWD}/keys/
