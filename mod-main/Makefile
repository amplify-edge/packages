


# This make file uses composition to keep things KISS and easy.
# In the boilerpalte make files dont do any includes, because you will create multi permutations of possibilities.



# git include
include ../boilerplate/help.mk
include ../boilerplate/os.mk
include ../boilerplate/flu.mk
include ../boilerplate/srv.mk


override FLU_SAMPLE_NAME =client/example
override FLU_LIB_NAME =client


## Print all settings
print: ## print
	@echo -- REPO -- 
	@echo REPOSITORY: $(REPOSITORY)
	@echo
	

	$(MAKE) os-print
	
	$(MAKE) flu-print

	$(MAKE) lang-print

	$(MAKE) srv-print

## So high
high: ## high
	@echo i wanna get...

.PHONY: protoc

protoc: protoc-go protoc-dart

protoc-go:
	protoc -I/usr/include/google/protobuf -Iserver/api/ server/api/*.proto \
		--go_out=plugins=grpc:server/pkg/api/

protoc-dart:
	protoc -Iserver/api/ server/api/*.proto --dart_out=grpc:client/lib/api/

install-dart-dep:
	pub global activate protoc_plugin