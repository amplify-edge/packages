


LIB_NAME=mine
LIB=github.com/winwisely99/webrtc-module/cloudwebrtc/$(LIB_NAME)
#LIB_BRANCH=desktop
LIB_BRANCH=master
LIB_FSPATH=$(GOPATH)/src/$(LIB)

# Flutter tools
MAKE_IMPORT=$(GOPATH)/src/github.com/winwisely99/webrtc-module/google-flutter-desktop


print:
	@echo
	@echo LIB_NAME: $(LIB_NAME)
	@echo LIB: $(LIB)
	@echo LIB_BRANCH: $(LIB_BRANCH)
	@echo LIB_FSPATH: $(LIB_FSPATH)

	@echo MAKE_IMPORT: $(MAKE_IMPORT)
	cd $(MAKE_IMPORT) && ls -al
	@echo
code:
	code $(LIB_FSPATH)

###

# Google FLutter Desktop
export ENABLE_FLUTTER_DESKTOP=true

flu-os-dep:
	# Need master to have Google Desktop and Web available.
	flutter channel master
	flutter channel

flu-config-print:
	cd $(MAKE_IMPORT) && $(MAKE) flu-config-print

	#flutter doctor
	#flutter devices

flu-config:
	cd $(MAKE_IMPORT) && $(MAKE) flu-config-clean
	cd $(MAKE_IMPORT) && $(MAKE) flu-config-desktop
	cd $(MAKE_IMPORT) && $(MAKE) flu-config-web
	cd $(MAKE_IMPORT) && $(MAKE) flu-config-mobile




SAMPLE_NAME=webrtc
SAMPLE_FSPATH=$(LIB_FSPATH)/$(SAMPLE_NAME)
flu-print:
	@echo SAMPLE_NAME: $(SAMPLE_NAME)
	@echo SAMPLE_FSPATH: $(SAMPLE_FSPATH)

flu-create:
	flutter create $(SAMPLE_NAME)

WEBRTC_FSPATH=$(GOPATH)/src/github.com/cloudwebrtc/flutter-webrtc-demo
WEBRTC_WORKSPACE=$(PWD)/../webrtc.code-workspace
flu-create-inject-code:
	code $(WEBRTC_WORKSPACE)
flu-create-inject:
	# copy bits needed from webrtc demo.
	ls $(WEBRTC_FSPATH)

	cp $(WEBRTC_FSPATH)/pubspec.yaml $(SAMPLE_FSPATH)
	rm -rf $(SAMPLE_FSPATH)/LIB
	cp -a $(WEBRTC_FSPATH)/lib/. $(SAMPLE_FSPATH)/lib

flu-create-clean:
	rm -rf $(SAMPLE_FSPATH)

flu-mob-run:
	cd $(MAKE_IMPORT) && $(MAKE) flu-config-mobile
	#cd $(LIB_FSPATH) && flutter clean
	cd $(SAMPLE_FSPATH) && flutter packages get
	#cd $(LIB_FSPATH) && flutter pub get
	cd $(SAMPLE_FSPATH) && flutter run -d all

flu-desk-run:
	cd $(MAKE_IMPORT) && $(MAKE) flu-config-desktop

	#cd $(LIB_FSPATH) && flutter clean
	cd $(LIB_FSPATH) && flutter packages get
	#cd $(LIB_FSPATH) && flutter pub get
	cd $(LIB_FSPATH) && flutter run 


flu-web-run:
	cd $(MAKE_IMPORT) && $(MAKE) flu-config-web

	#cd $(LIB_FSPATH) && flutter clean
	cd $(LIB_FSPATH) && flutter packages get
	#cd $(LIB_FSPATH) && flutter pub get
	cd $(LIB_FSPATH) && flutter run 
	
flu-web-open:
	open http://$(LIB)