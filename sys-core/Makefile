# includes
BOILERPLATE_FSPATH=./../boilerplate

include $(BOILERPLATE_FSPATH)/help.mk
include $(BOILERPLATE_FSPATH)/os.mk
include $(BOILERPLATE_FSPATH)/tool.mk


# NOT needed for v2
#DEP_GEN_FSPATH=./../boilerplate
#DEP_LIB_PROTOGEN=protofig


this-dep:
	
	@echo -- DEP ALL: start --

	@echo -- EP ALL: finish --	

this-gen:

	@echo -- GEN ALL: start --

	@echo -- GEN ALL: finish --	


# CI and local call this
## Build everything
this-build: this-dep this-gen

	@echo -- BUILD ALL: start --

	#cd ./server && $(MAKE) this-mods-build

	@echo -- BUILD ALL: finish --


this-build-all:
	## TODO: Build all like we do in core-bs


