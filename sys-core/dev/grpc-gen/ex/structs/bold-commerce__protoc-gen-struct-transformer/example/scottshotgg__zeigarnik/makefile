# https://github.com/scottshotgg/zeigarnik

LIB=github.com/scottshotgg/zeigarnik
LIB_FSPATH=$(GOPATH)/src/$(LIB)
LIB_BIN=$(GOPATH)/bin/zds

TOOL_FSPATH=$(PWD)/../../../../../tool
#TOOL_FSPATH=/Users/apple/workspace/go/src/github.com/joe-getcouragenow/junk/archi/grpc/tool

print:
	@echo $(LIB_FSPATH)
dep:
	git clone https://$(LIB) $(LIB_FSPATH)
dep-del:
	rm -rf $(LIB_FSPATH)
vscode-add:
	code --add $(LIB_FSPATH) --reuse-window

### GEN

gen-dep-which:
	cd $(TOOL_FSPATH) && $(MAKE) grpc-which 
gen-dep-all:
	cd $(TOOL_FSPATH) && $(MAKE) grpc-all
gen-run:
	#cd $(LIB_FSPATH) && chmod +x bin/gen_buffs.sh
	#cd $(LIB_FSPATH) && bin/gen_buffs.sh

	cp gen.sh $(LIB_FSPATH)/gen.sh
	cd $(LIB_FSPATH) && chmod +x ./gen.sh
	cd $(LIB_FSPATH) && ./gen.sh

### RUN
go-run:
	# RUNS :)
	cd $(LIB_FSPATH) && go run .


