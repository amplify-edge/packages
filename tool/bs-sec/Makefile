
# https://github.com/securego/gosec


# includes
BOILERPLATE_FSPATH=./../../boilerplate

include $(BOILERPLATE_FSPATH)/help.mk
include $(BOILERPLATE_FSPATH)/tool.mk
include $(BOILERPLATE_FSPATH)/go.mk


NAME=bs-sec

print:
	@echo print

## Fixed so mod
mod:
	$(MAKE) go-mod-update

build:
	go build -o $(GOPATH)/bin/$(NAME) main.go
	which $(NAME)

security:
	@NAME ./...
	@echo "[OK] Go security check was completed!"


	

