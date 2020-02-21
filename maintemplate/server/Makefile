.DEFAULT_GOAL       := help
VERSION             := v0.0.0
TARGET_MAX_CHAR_NUM := 20

GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

.PHONY: help build prepare flu-web-run flu-mob-run clean

## Show help
help:
	@echo 'Package eris provides a better way to handle errors in Go.'
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

## Run the code
deploy:
	@echo Running
	@eval $$(minikube -p minikube docker-env)
	@cp -rf ../client/build/web flutter/
	@docker build --tag localhost:5000/grpc-web grpc-web/
	@docker build --tag localhost:5000/flutter-web flutter/
	@minikube addons enable registry
	while [ "`kubectl get pods --namespace kube-system -l kubernetes.io/minikube-addons=registry -l actual-registry=true -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}' | cut -f1`" != "True" ]]; do echo "waiting for minkube registry" && sleep 1; done
	@eval $$(minikube -p minikube docker-env) && docker push localhost:5000/grpc-web
	@eval $$(minikube -p minikube docker-env) && docker push localhost:5000/flutter-web
	@curl -o kustomize --location https://github.com/kubernetes-sigs/kustomize/releases/download/v3.1.0/kustomize_3.1.0_linux_amd64
	@chmod u+x ./kustomize
	@touch kustomization.yaml
	@./kustomize edit add resource k8s/*
	@./kustomize edit set image "gcr.io/GKE_PROJECT/IMAGE:TAG"="localhost:5000/grpc-web:latest"
	@./kustomize edit set image "gcr.io/GKE_PROJECT/flutter-web-IMAGE:TAG"="localhost:5000/flutter-web:latest"
	@./kustomize build . | kubectl replace --force -f -
	@rm kustomization.yaml ./kustomize	
	@rm -rf flutter/web

## Connect gRPC web
connect-grpc-web:
	@kubectl port-forward svc/envoy 8074:443

## Connect gRPC
connect-grpc:
	@kubectl port-forward svc/grpc-web 9074:9074

## Connect Flutter web
connect-flutter-web:
	@kubectl port-forward svc/flutter 8001:80