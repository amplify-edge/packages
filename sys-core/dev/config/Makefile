# https://github.com/uber-go/config

# EX: https://github.com/m3db/m3/blob/master/Makefile#L271

LIB=github.com/uber-go/config
LIB_FSPATH=$(GOPATH)/src/$(LIB)
LIB_BIN_FSPATH=$(PWD)/bin/config



print:
	@echo
	@echo
	@echo LIB: $(LIB)
	@echo LIB_FSPATH: $(LIB_FSPATH)
	@echo LIB_BIN_FSPATH: $(LIB_BIN_FSPATH)
	@echo
	@echo
dep:
	git clone https://$(LIB) $(LIB_FSPATH)
dep-del:
	rm -rf $(LIB_FSPATH)
vscode-add:
	code --add $(LIB_FSPATH) --reuse-window

### LIB

lib-build:
	mkdir -p $(PWD)/bin
	#cd $(LIB_FSPATH) && go build -o $(LIB_BIN_FSPATH) .

	cd $(LIB_FSPATH) && go build ./...
	
lib-run:
	$(LIB_BIN_FSPATH)

