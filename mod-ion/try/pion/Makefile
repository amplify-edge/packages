

# github.com/pion/webrtc

LIB_NAME=webrtc
LIB=github.com/pion/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)

LIB_BIN_NAME=$(LIB_NAME)
LIB_BIN_FSPATH=$(GOPATH)/bin/$(LIB_BIN_NAME)

SAMPLE_NAME=examples/save-to-disk
SAMPLE_FSPATH=$(LIB_FSPATH)/$(SAMPLE_NAME)

print:
	@echo
	@echo LIB_NAME: $(LIB_NAME)
	@echo LIB: $(LIB)
	@echo LIB_BRANCH: $(LIB_BRANCH)
	@echo LIB_FSPATH: $(LIB_FSPATH)

	@echo
	@echo LIB_BIN_NAME: $(LIB_BIN_NAME)
	@echo LIB_BIN_FSPATH: $(LIB_BIN_FSPATH)
	@echo

	@echo
	@echo SAMPLE_NAME: $(SAMPLE_NAME)
	@echo SAMPLE_FSPATH: $(SAMPLE_FSPATH)
	@echo

git-clone:
	# need flutter desktop :)
	mkdir -p $(LIB_FSPATH)
	cd $(LIB_FSPATH) && cd .. && rm -rf $(LIB_NAME) && git clone ssh://git@$(LIB).git
	cd $(LIB_FSPATH) && git checkout $(LIB_BRANCH)
git-pull:
	cd $(LIB_FSPATH) && git pull
git-clean:
	rm -rf $(LIB_FSPATH)

code:
	code $(LIB_FSPATH)

os-dep:
	

go-build-list:
	@echo
	@echo Listing binaries:

	stat $(LIB_BIN_FSPATH)
	stat $(LIB_BIN_FSPATH).exe

go-build:
	cd $(LIB_FSPATH) && GOOS=darwin go build -o $(LIB_BIN_FSPATH) .
	cd $(LIB_FSPATH) && GOOS=windows go build -o $(LIB_BIN_FSPATH).exe .

	$(MAKE) go-build-list
go-build-clean:
	rm -f $(LIB_BIN_FSPATH)
	rm -f $(LIB_BIN_FSPATH).exe

	$(MAKE) go-build-list

sam-run:
	cd $(SAMPLE_FSPATH) && go run .
sam-op1:
	echo $BROWSER_SDP | save-to-disk
