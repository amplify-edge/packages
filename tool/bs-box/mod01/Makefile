.PHONY: generate

NAME=mod01

print:
	@echo hey

generate:
	@go generate ./...
	@echo "[OK] Files added to embed box!"

security:
	@gosec ./...
	@echo "[OK] Go security check was completed!"

build: generate security
	@go build -o ./build/$(NAME) ./cmd/app/*.go
	@echo "[OK] App binary was created!"

run:
	@./build/$(NAME)
