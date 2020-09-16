# https://github.com/sayboras/zds

LIB=github.com/sayboras/zds
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

build:
	cd $(LIB_FSPATH) && $(MAKE)