# https://github.com/gen0cide/cfx-example

# Uses github.com/gen0cide/cfx, which uses https://github.com/uber-go/config

LIB=github.com/gen0cide/cfx-example
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

### ex
	
ex-run:
	cd $(LIB_FSPATH)/cmd/cfx-example && EXAMPLE_FOO_BAR_APP_ID=example-app go run main.go

ex-run1:
	cd $(LIB_FSPATH)/cmd/cfx-example && name1=app1 go run main.go

# TODO
# foo and bar are compacted into base.yaml. 