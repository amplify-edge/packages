


include ../../../boilerplate/help.mk
include ../../../boilerplate/os.mk
include ../../../boilerplate/env.mk
include ../../../boilerplate/gitu.mk
include ../../../boilerplate/k8.mk

#include ../../../boilerplate/srv.mk
#include ../../../boilerplate/flu.mk
#include ../../../boilerplate/lang.mk


# hard override. Can also suck in exported environment variables
# Later wil be driven by the protoconfig system and suck up values from disk. Like DIRENV

override ENV_SOURCE=joe
override FLU_SAMPLE_NAME=clientXXX


## Print all settings
print: ## print
	$(MAKE) os-print
	$(MAKE) env-print
	$(MAKE) k8-print


## Get all dependencies

NATS_LIB=github.com/nats-io/nats-server
NATS_LIB_FSPATH=$(GOPATH)/src/$(NATS_LIB)
NATS_LIB_BIN_NAME=nats-server
NATS_LIB_BIN_FSPATH=$(GOPATH)/bin/$(NATS_LIB_BIN_NAME)

LIFT_LIB=github.com/liftbridge-io/liftbridge
LIFT_LIB_FSPATH=$(GOPATH)/src/$(LIFT_LIB)
LIFT_LIB_BIN_NAME=liftbridge
LIFT_LIB_BIN_FSPATH=$(GOPATH)/bin/$(LIFT_LIB_BIN_NAME)

## Prints deps
dep-print: ## dep-print
	@echo
	@echo -- NATS --
	@echo NATS_LIB: 			$(NATS_LIB)
	@echo NATS_LIB_FSPATH: 		$(NATS_LIB_FSPATH)
	@echo NATS_LIB_BIN_NAME: 	$(NATS_LIB_BIN_NAME)
	@echo NATS_LIB_BIN_FSPATH: 	$(NATS_LIB_BIN_FSPATH)
	@echo 
	@echo -- LIFTBRIDGE --
	@echo LIFT_LIB: 			$(LIFT_LIB)
	@echo LIFT_LIB_FSPATH: 		$(LIFT_LIB_FSPATH)
	@echo LIFT_LIB_BIN_NAME: 	$(LIFT_LIB_BIN_NAME)
	@echo LIFT_LIB_BIN_FSPATH: 	$(LIFT_LIB_BIN_FSPATH)
	@echo

## Gets dependencies
dep: ## dep
	$(MAKE) dep-liftbridge
	$(MAKE) dep-nats

dep-liftbridge:
	GO111MODULE=off go get -d $(LIFT_LIB)


dep-nats:
	GO111MODULE=off go get -d $(NATS_LIB)

## Build all deps
dep-build: ## dep-build
	cd $(NATS_LIB_FSPATH) && go build -o $(NATS_LIB_BIN_FSPATH)
	which $(NATS_LIB_BIN_NAME)

	cd $(LIFT_LIB_FSPATH) && go build -o $(LIFT_LIB_BIN_FSPATH)
	which $(LIFT_LIB_BIN_NAME)

## Runs all dependencies
dep-run: ## dep-run
	$(NATS_LIB_BIN_NAME) -h

