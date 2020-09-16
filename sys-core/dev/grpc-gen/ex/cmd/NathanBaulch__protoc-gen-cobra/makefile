# https://github.com/NathanBaulch/protoc-gen-cobra

LIB=github.com/NathanBaulch/protoc-gen-cobra
LIB_FSPATH=$(GOPATH)/src/$(LIB)

#ALMOST Perfect
# https://github.com/fiorix/protoc-gen-cobra/issues/7


print:
	@echo $(LIB_FSPATH)
dep:
	git clone https://$(LIB) $(LIB_FSPATH)
dep-del:
	rm -rf $(LIB_FSPATH)
vscode-add:
	code --add $(LIB_FSPATH) --reuse-window

### LIB
LIB_BIN=$(PWD)/bin/protoc-gen-cobra
lib-build:
	mkdir -p $(PWD)/bin
	cd $(LIB_FSPATH) && go build -o $(LIB_BIN) .
lib-run:
	$(LIB_BIN)

deps-print:

### EX
ex-gen:
	# this gens all the CMD code for the example !!
	@echo
	@echo -- Delete the bin deps
	cd $(LIB_FSPATH)/example/pb && $(MAKE) deps-delete
	@echo

	@echo -- Get bin deps
	cd $(LIB_FSPATH)/example/pb && $(MAKE) deps
	@echo

	@echo -- Delete generated files
	cd $(LIB_FSPATH)/example/pb && $(MAKE) clean
	@echo

	@echo -- DO the gen generated files
	cd $(LIB_FSPATH)/example/pb && $(MAKE) 
	@echo
ex-gen-del:
	# this deletes the generated CMD files
	cd $(LIB_FSPATH)/example/pb && $(MAKE) clean

## Real example

LIB_EX_SRV_BIN=$(PWD)/bin/ex-srv
ex-server-build:
	mkdir -p $(PWD)/bin
	cd $(LIB_FSPATH)/example/server && go build -o $(LIB_EX_SRV_BIN) .
ex-server-run:
	$(LIB_EX_SRV_BIN)

LIB_EX_CLI_BIN=$(PWD)/bin/ex-cli
ex-cli-build:
	mkdir -p $(PWD)/bin
	cd $(LIB_FSPATH)/example && go build -o $(LIB_EX_CLI_BIN) .
ex-cli-run:
	$(LIB_EX_CLI_BIN) bank deposit --account joe --amount 100 
	$(LIB_EX_CLI_BIN) bank deposit --account joe --amount 100 