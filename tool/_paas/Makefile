# This make file uses composition to keep things KISS and easy.
# In the boilerpalte make files dont do any includes, because you will create multi permutations of possibilities.


# includes
BOILERPLATE_FSPATH=./../../boilerplate

include $(BOILERPLATE_FSPATH)/core/help.mk
include $(BOILERPLATE_FSPATH)/core/dock.mk


override GO_EXT_DEPS = github.com/git-chglog/git-chglog/cmd/git-chglog

## OS Deps for CI
# this-os-deps:
	# TODO doesn't work
	# echo "::set-env name=GOPATH::${{ github.workspace }}/go"
	# echo "::add-path::${{ github.workspace }}/go/bin"
	# echo "::add-path::$HOME/.pub-cache/bin"
	# mkdir -p "${{ github.workspace }}"/go/{src,bin,pkg}

this-flu-activate-plugin:
	pub global activate protoc_plugin

## Print all settings
this-print:
	TODO


### BUILD Phase

## Builds all tools
this-tools-build:
	# reach into each ones make and build
	cd tool/dummy && $(MAKE) this-build
	cd tool/protofig/protoc-gen-configdef && $(MAKE) this-build
	cd tool/protofig && $(MAKE) this-build

## Builds all tools for all platforms
this-tools-build-all:
	# go to tool and run Makefile from there
	cd tool && ${MAKE} this-assets-release

# CI and local call this
## Build everything
this-build:
	@echo -- Root - BUILD: start --
	cd ./tool && $(MAKE) this-build
	cd ./sys-core && $(MAKE) this-build
	cd ./mod-settings && $(MAKE) this-build
	cd ./mod-account && $(MAKE) this-build

	@echo -- Root - BUILD: finish --

this-tools-docker-build:
	docker build -t bs-protofig:latest -f tool/protofig/Dockerfile .

this-tools-docker-example:
	docker run -v $(PWD):/hostvol \
		--rm -it bs-protofig:latest /protofig/bs-protofig \
		-f /hostvol/example/protofig/config.default-winwisely.json \
		-u winwiselyexample -o /hostvol/example/protofig/output

### TEST Phase

# CI and local cal this
## tets all tool and modules
this-test:
	@echo -- Root - BUILD: start --

	cd ./tool && $(MAKE) this-test
	cd ./sys-core && $(MAKE) this-test
	cd ./mod-settings && $(MAKE) this-test
	cd ./mod-account && $(MAKE) this-test

	@echo -- Root - BUILD: finish --


## TAGS AND GIT


## Tags the tools via git, example: VERSION="YOUR_TAG" make this-tag
this-tag: this-deps
	# tag it
	$(MAKE) gitr-release-tag

# Releases a build
this-release: this-tools-build
	# runs off a tag event or a specified tag
	$(MAKE) gitr-release-push

# Releases all builds
this-release-all: this-tools-build-all
	${MAKE} gitr-release-push
	
## Install external dependencies for tagging
this-deps:
	# install git-chglog
	$(MAKE) go-exts-get

## Cleans external dependencies for tagging
this-deps-clean:
	$(MAKE) go-exts-clean
