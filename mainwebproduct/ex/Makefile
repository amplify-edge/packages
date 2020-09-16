# https://github.com/sbis04/explore

LIB=github.com/sbis04/explore
LIB_FSPATH=$(GOPATH)/src/$(LIB)
dep:
	git clone https://$(LIB) $(LIB_FSPATH)
dep-delete:
	rm -rf $(LIB_FSPATH)

vscode-add:
	code --add --reuse-window $(LIB_FSPATH)

flu-web-run:
	cd $(LIB_FSPATH) && flutter run -d chrome
