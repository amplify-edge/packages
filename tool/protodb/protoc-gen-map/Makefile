
BOILERPLATE_FSPATH=./../../../boilerplate
include $(BOILERPLATE_FSPATH)/core/help.mk
include $(BOILERPLATE_FSPATH)/core/gitr.mk
include $(BOILERPLATE_FSPATH)/core/flu.mk
include $(BOILERPLATE_FSPATH)/core/go.mk

FLU_SAMPLE_NAME=cmd/client/flu

override GO_FSPATH=$(PWD)/cmd/client/go
override GO_BUILD_OUT_ALL_FSPATH=${PWD}/builds/
override GO_BIN_NAME=protoc-gen-map
override GO_EXTS_DEPS = github.com/jackskj/protoc-gen-map

## install external dependencies
this-dep:
	${MAKE} go-exts-get

## clean external dependencies
this-dep-clean:
	${MAKE} go-exts-clean

## int the proj
this-init:
	# one time thing
	cd cmd/client/flu && flutter create .

## generate .pb.go and pb.map.go files
this-gen: this-gen-clean
	cd examples && protoc --map_out="sql=./sql:." \
        --go_out="plugins=grpc:."   \
        -I=. \
        ./query.proto
# clean out the generated files		
this-gen-clean:
	rm -rf examples/gen

## RUN

## run server
this-server-run:
	cd cmd/server && go run main.go

## build server
this-server-build:
	cd cmd/server && go build -o $(GOPATH)/bin/bs-protoc-gen-map main.go 

## run flu client
this-flu-run:
	#$(MAKE) flu-desk-init 
	$(MAKE) flu-desk-run 


## run flu client
this-go-run:
	$(MAKE) go-run



