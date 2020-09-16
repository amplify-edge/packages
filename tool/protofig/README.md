# Readme

Install both protoc-gen-msgnames and protoc-gen-config (via `make install`)

## Usage

Run ```make proto-go```
Edit the generated value in ```config/config.<your_username>.default.json```


Given the populated json global config, the tool will validate and generate these files (as defined by protobuf schema):
1. Shell environment files (which you could source in your $SHELL profile)
2. Json files (as defined in protobuf schema)
3. K8s Secrets (YAML files)

See Makefile for usage.

