

# Upstream:https://github.com/asishrs/proxyless-grpc-lb
# Fork: https://github.com/joe-getcouragenow/proxyless-grpc-lb

CWD:=$(shell echo `pwd`)

GO_OS 		:= $(shell go env GOOS)
GO_ARCH		:= $(shell go env GOARCH)
GIT_VERSION	:= $(shell git describe --tags)

LIB=github.com/asishrs/proxyless-grpc-lb
#LIB=github.com/joe-getcouragenow/proxyless-grpc-lb
LIB_TAG=v1.19.1
LIB_FSPATH=$(GOPATH)/src/$(LIB)
LIB_BIN_FSPATH=$(PWD)/bin
LIB_DATA_FSPATH=$(PWD)/data

LIB_BIN_NAME_SERVER=blobstash
LIB_BIN_NAME_RESTORE=blobstash-s3-restore
LIB_BIN_NAME_UPLOAD=blobstash-uploader


export GO111MODULE=on

print:
	@echo
	@echo GO_OS : $(GO_OS)
	@echo GO_ARCH : $(GO_ARCH)
	@echo GIT_VERSION : $(GIT_VERSION)
	@echo
	@echo
	@echo LIB : $(LIB)
	@echo LIB_FSPATH : $(LIB_FSPATH)
	@echo LIB_BIN_FSPATH : $(LIB_BIN_FSPATH)
	@echo LIB_DATA_FSPATH : $(LIB_DATA_FSPATH)
	@echo LIB_XBIN : $(LIB_XBIN)
	@echo LIB_BIN : $(LIB_BIN)

	@echo 
dep-os:
	brew install go-task/tap/go-task
	# https://k3d.io/
	brew install k3d

	# https://github.com/skanehira/docui
	brew tap skanehira/docui
	brew install docui

dep:
	git clone https://$(LIB).git $(LIB_FSPATH)
dep-tag: dep
	cd $(LIB_FSPATH) && git fetch --all --tags --prune && git checkout tags/$(LIB_TAG)
dep-delete:
	rm -rf $(LIB_FSPATH)
vscode-add:
	code --add $(LIB_FSPATH) --reuse-window


### K3D

k3d-print:
	@echo
	# -- Cluster --
	kubectl cluster-info

	@echo
	# -- Nodes --
	kubectl get nodes 

	@echo
	# -- Verify all Deployments: Should see 5 --
	kubectl get deployments.apps
	
	@echo
	# -- Verify all Services: Should see 4 --
	kubectl get svc
	@echo

	@echo
	# -- Verify all Pods: Should see 7 --
	kubectl get pods

### K3D
k3d-create:
	cd $(LIB_FSPATH) && task k3d:create
k3d-start:
	cd $(LIB_FSPATH) && task k3d:start
k3d-delete:
	cd $(LIB_FSPATH) && task k3d:delete
k3d-stop:
	cd $(LIB_FSPATH) && task k3d:stop

### ALL
all-remove:
	cd $(LIB_FSPATH) && task remove
all-deploy:
	cd $(LIB_FSPATH) && task deploy


### XDS
xds-build:
	cd $(LIB_FSPATH) && task xds:build
xds-deploy:
	cd $(LIB_FSPATH) && task xds:deploy
	#kubectl logs -f deployment/xds-server


### GRPC Server
server-build:
	cd $(LIB_FSPATH) && task server:build
server-deploy:
	cd $(LIB_FSPATH) && task server:deploy
	#kubectl logs -f deployment/hello-server
server-scale:
	kubectl scale --replicas=5 deployments.apps/hello-server
	kubectl scale --replicas=5 deployments.apps/howdy-server


### GRPC Client
client-build:
	cd $(LIB_FSPATH) && task client:build
client-deploy:
	cd $(LIB_FSPATH) && task client:deploy
	#kubectl logs -f deployment/hello-client
client-scale:
	kubectl scale --replicas=5 deployments.apps/hello-client
	kubectl scale --replicas=5 deployments.apps/howdy-client





