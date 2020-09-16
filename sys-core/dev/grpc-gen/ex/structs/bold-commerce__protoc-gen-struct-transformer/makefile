# https://github.com/bold-commerce/protoc-gen-struct-transformer

LIB=github.com/bold-commerce/protoc-gen-struct-transformer
LIB_FSPATH=$(GOPATH)/src/$(LIB)
LIB_BIN=$(GOPATH)/bin/zds


print:
	@echo $(LIB_FSPATH)
dep:
	git clone https://$(LIB) $(LIB_FSPATH)
dep-del:
	rm -rf $(LIB_FSPATH)
vscode-add:
	code --add $(LIB_FSPATH) --reuse-window

dep-os:
	go get -u github.com/gogo/protobuf/protoc-gen-gogofaster

install: dep-os
	# Installs the generator and any deps.
	cd $(LIB_FSPATH) && $(MAKE) build
ex-gen:
	# Runs the generator on the example.
	cd $(LIB_FSPATH) && $(MAKE) generate
ex-gen-debug:
	# Runs the generator on the example.
	cd $(LIB_FSPATH) && $(MAKE) generate-debug
ex-run:
	# Use my main to run it
	go run main.go

dart-gen:
	# Make sure Dart can handle it.

