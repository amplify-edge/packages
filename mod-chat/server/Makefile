.DEFAULT_GOAL       := help
VERSION             := v0.0.0
TARGET_MAX_CHAR_NUM := 20

JETSTREAM_TAG = 0.10.0

GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

RANDTAG := $(shell head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo '')

.PHONY: help build prepare flu-web-run flu-mob-run clean

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


###### nats ######
install-nats:
	# install nats server
	go get -u github.com/nats-io/nats-server

nats:
	# start nats server
	nats-server

###### liftbridge ######
install-liftbridge:
	# install liftbridge server
	go get github.com/liftbridge-io/liftbridge

lift:
	# start liftbridge
	mkdir -p lift_cache
	liftbridge -c grpc-web/liftbridge/config.conf --raft-bootstrap-seed -d lift_cache

###### jetstream ######
config-nats-jets:
	# config nats to use jetstream
	cd $(GOPATH)/src/github.com/ && git clone https://github.com/nats-io/nats-server.git
	cd $(GOPATH)/src/github.com/nats-server && git checkout jetstream
	cd $(GOPATH)/src/github.com/nats-server && go build
	cd $(GOPATH)/src/github.com/nats-server && mv ./nats-server $(GOPATH)/bin 

config-nats:
	# setup nats jetstream client
	cd $(GOPATH)/src/github.com/ && rm -rf jetstream
	mkdir -p $(GOPATH)/src/github.com/jetstream
	cd $(GOPATH)/src/github.com/jetstream && git clone https://github.com/nats-io/jetstream.git --tags $(JETSTREAM_TAG)
	cd $(GOPATH)/src/github.com/jetstream/$(JETSTREAM_TAG)/nats && go build
	cd $(GOPATH)/src/github.com/jetstream/$(JETSTREAM_TAG)/nats && mv ./nats $(GOPATH)/bin

start-jetstream:
	# start nats-server
	mkdir -p nats
	nats-server -js -sd ./nats

###### nats streaming server ######
config-nss:
	# install nats-streaming-server
	go get github.com/nats-io/nats-streaming-server

nss:
	# start nats-streaming-server
	nats-streaming-server -SD -SV -SDV

go-srv:
	cd cmd && go run server.go

go-cli:
	cd cmd && go run client.go

faker:
	cd cmd && go run faker.go

