.DEFAULT_GOAL       := help
VERSION             := v0.0.0
TARGET_MAX_CHAR_NUM := 20

GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

RANDTAG := $(shell head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo '')


## Show help
help:
	@echo 'Server for mainTemplate'
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



## Local run
local-run:
	go run ./grpc-web/cmd/server/main.go

## minikube run
deploy:
	@echo Running
	@eval $$(minikube -p minikube docker-env)
	@cp -rf ../client/build/web flutter/
	@docker build --tag localhost:5000/grpc-web:1 grpc-web/
	@docker build --tag localhost:5000/flutter-web:2 flutter/
	@minikube addons enable ingress
	@minikube addons enable registry
	@while [ "`kubectl get pods --namespace kube-system -l kubernetes.io/minikube-addons=registry -l actual-registry=true -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}' | cut -f1`" != "True" ]]; do echo "waiting for minkube registry" && sleep 1; done
	@docker push localhost:5000/grpc-web:1
	@docker push localhost:5000/flutter-web:2
	@curl -o kustomize --location https://github.com/kubernetes-sigs/kustomize/releases/download/v3.1.0/kustomize_3.1.0_linux_amd64
	@chmod u+x ./kustomize
	@touch kustomization.yaml
	@./kustomize edit add resource k8s/*
	@./kustomize edit set image "gcr.io/GKE_PROJECT/IMAGE:TAG"="localhost:5000/grpc-web:1"
	@./kustomize edit set image "gcr.io/GKE_PROJECT/flutter-web-IMAGE:TAG"="localhost:5000/flutter-web:2"
	@./kustomize build . | kubectl replace --force -f -
	@kubectl annotate ingress maintemplate nginx.ingress.kubernetes.io/use-regex="true"
	@rm kustomization.yaml 
	@rm -rf flutter/web ./kustomize	

protoc-go:
	protoc -I grpc-web/pkg/proto grpc-web/pkg/proto/v2.proto --gofast_out=plugins=grpc:./grpc-web/pkg/api/v2

######## Test golang client/serveur ########
# 1. make nats
# 2. make lift
# 3. make svr-go
# 4. make cli-go

nats:
	# start nats container
	docker run -d --name nats-main -p 4222:4222 -p 6222:6222 -p 8222:8222 nats 

lift:
	# start liftbridge
	mkdir lift_cache
	liftbridge -c grpc-web/liftbridge/config.conf --raft-bootstrap-seed -d lift_cache

svr-go:
	# start serveur
	cd grpc-web/cmd/server && go run main.go

cli-go:
	# start a client
	cd go-client && go run main.go
