

# https://github.com/cloudwebrtc/flutter-webrtc-server
# nodejs


LIB_NAME=flutter-webrtc-server
LIB=github.com/cloudwebrtc/$(LIB_NAME)
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)

# Flutter tools
MAKE_IMPORT=$(GOPATH)/src/github.com/winwisely99/mod-videoconf/google-flutter-desktop


print:
	@echo
	@echo LIB_NAME: $(LIB_NAME)
	@echo LIB: $(LIB)
	@echo LIB_BRANCH: $(LIB_BRANCH)
	@echo LIB_FSPATH: $(LIB_FSPATH)

	@echo MAKE_IMPORT: $(MAKE_IMPORT)
	cd $(MAKE_IMPORT) && ls -al
	@echo

git-print:
	cd $(LIB_FSPATH) && git status
git-clone:
	mkdir -p $(LIB_FSPATH)
	cd $(LIB_FSPATH) && cd .. && rm -rf $(LIB_NAME) && git clone ssh://git@$(LIB).git
	cd $(LIB_FSPATH) && git checkout $(LIB_BRANCH)
git-pull:
	cd $(LIB_FSPATH) && git pull
git-clean:
	rm -rf $(LIB_FSPATH)

WEBRTC_WORKSPACE=$(PWD)/../webrtc.code-workspace
code:
	code $(WEBRTC_WORKSPACE)

### certs 

# Start using https://github.com/mholt/certmagic
# - For k8 or any cluster just need to use the smae storgae

CERT_LIB=github.com/foomo/simplecert
CERT_FSPATH=$(GOPATH)/src/$(CERT_LIB)
cert-dep:
	GO111MODULE=off go get -u -v $(CERT_LIB)

cert-code:
	code $(CERT_FSPATH)

### npm




### Firebase & npm

### firebase seems easiest for now.

NPM_DIST_FSPATH=$(PWD)/dist
FB_NAME=flutter-webrtc-server
FB_FSPATH=$(PWD)/firebase
FB_URL=flu-webrtc.dev.winwisely.net

fb-print:
	@echo
	@echo NPM_DIST_FSPATH: 	$(NPM_DIST_FSPATH)
	@echo FB_NAME: 			$(FB_NAME)
	@echo FB_FSPATH: 		$(FB_FSPATH)
	@echo FB_URL: 			$(FB_URL)
	@echo




fb-dep:
	brew install yarn
	yarn install -g firebase-tools
	npm i -g firebase-tools

fb-npm-run:
	# works :)
	cd $(LIB_FSPATH) && npm install
	cd $(LIB_FSPATH) && npm start
	# Start WS Server: bind => ws://0.0.0.0:4442
	# Start WSS Server: bind => wss://0.0.0.0:4443
fb-npm-build:
	# works :)
	# build into local DIST
	cd $(LIB_FSPATH) && npm run-script build
	cp -a $(LIB_FSPATH)/dist/. $(NPM_DIST_FSPATH)

fb-config:
	firebase login
	firebase projects:list

fb-init:
	# region: europe-west3
	cd $(FB_FSPATH) && firebase init
fb-init-open:
	open https://console.firebase.google.com/project/$(FB_NAME)/overview?pli=1
fb-inject:
	cp -a $(NPM_DIST_FSPATH)/. $(FB_FSPATH)/public
fb-serve:
	cd $(FB_FSPATH) && firebase serve
fb-deploy:
	cd $(FB_FSPATH) && firebase deploy
fb-deploy-open:
	open https://$(FB_NAME).firebaseapp.com/

fb-www-open:
	open https://$(FB_URL)

## gcloud is easier ?




