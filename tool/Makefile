
BOILERPLATE_FSPATH=../boilerplate

include $(BOILERPLATE_FSPATH)/help.mk
include $(BOILERPLATE_FSPATH)/gitr.mk
include $(BOILERPLATE_FSPATH)/go.mk
include $(BOILERPLATE_FSPATH)/tool.mk

## Print all settings
this-print:
	$(MAKE) go-print

	$(MAKE) tool-print

# CI smoke test
this-ci-smoke:

	@echo -- TOOLS - CI SMOKE TEST: start --
	
	$(MAKE) this-build
	$(MAKE) this-test
	$(MAKE) this-build-clean

	@echo -- TOOLS - CI SMOKE TEST: end --

## Build all tools
this-build:

	@echo -- TOOLS - BUILD ALL: start --

	@echo Dummy
	cd ./$(TOOL_DUMMY_BIN_NAME) && $(MAKE) this-build

	@echo Lang
	cd ./$(TOOL_LANG_BIN_NAME) && $(MAKE) this-build

	@echo Hover
	cd ./$(TOOL_HOVER_BIN_NAME) && $(MAKE) this-build

	@echo Hugo
	cd ./$(TOOL_HUGO_BIN_NAME) && $(MAKE) this-build

	# The things below do not work yet and are not going to be needed for v2

	#@echo protoc-gen-configdef
	#cd ./protofig/protoc-gen-configdef && $(MAKE) this-build

	#@echo protoc-gen-map
	#cd ./protodb/protoc-gen-map && $(MAKE) this-build

	#@echo Protofig
	#cd ./protofig && $(MAKE) this-build

	#@echo Protodb
	#cd ./protodb && $(MAKE) this-build

	# -- PLUS ALL OTHER TOOLS !!

	@echo -- TOOLS - BUILD ALL: finish --



## Clean the build
this-build-clean:

	@echo -- TOOLS - CLEAN ALL: start --

	@echo Dummy
	cd ./$(TOOL_DUMMY_BIN_NAME) && $(MAKE) this-build-clean

	@echo Lang
	cd ./$(TOOL_LANG_BIN_NAME) && $(MAKE) this-build-clean

	@echo Hover
	cd ./$(TOOL_HOVER_BIN_NAME) && $(MAKE) this-build-clean

	@echo Hugo
	cd ./$(TOOL_HUGO_BIN_NAME) && $(MAKE) this-build-clean

	# The things below do not work yet and are not going to be needed for v2

	#@echo protoc-gen-configdef
	#cd ./protofig/protoc-gen-configdef && $(MAKE) this-build

	#@echo protoc-gen-map
	#cd ./protodb/protoc-gen-map && $(MAKE) this-build

	#@echo Protofig
	#cd ./protofig && $(MAKE) this-build

	#@echo Protodb
	#cd ./protodb && $(MAKE) this-build

	# -- PLUS ALL OTHER TOOLS !!

	@echo -- TOOLS - CLEAN ALL: finish --

## Test all tools
this-test:
	@echo -- TOOLS - TEST ALL: start --

		@echo Dummy
	cd ./$(TOOL_DUMMY_BIN_NAME) && $(MAKE) this-test

	@echo Lang
	cd ./$(TOOL_LANG_BIN_NAME) && $(MAKE) this-test

	@echo Hover
	cd ./$(TOOL_HOVER_BIN_NAME) && $(MAKE) this-test

	@echo Hugo
	cd ./$(TOOL_HUGO_BIN_NAME) && $(MAKE) this-test

	# The things below do not work yet and are not going to be needed for v2

	#@echo Protofig
	#cd ./protofig && $(MAKE) this-test

	#@echo Protodb
	#cd ./protodb && $(MAKE) this-test
	# -- PLUS ALL OTHER TOOLS !!

	@echo -- TOOLS - TEST ALL: finish --


