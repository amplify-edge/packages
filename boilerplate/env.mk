# env for managing environment settings

# Concept
# does alot of codegen
# the final env file is based on a template and a per environment values file.
# the two are run to produce an env file.
# the final environment file is then used by the server, client, infra ete to run

# In the CLI and Flutter client we intend to use protobufs
# the env file is just JSON that is produced from a protobuf
# so all users of the env data can have loaders code generated from the original protobuf for eading their env settings at runtime.
# this provides a strong typing and also schema evolution so we can use the same system to do feature flags

ENV_SOURCE ?= env_source
ENV_TEMPLATE ?= env_template
ENV_TARGET ?= env_target.json

## Prints the env settings
env-print: ## env-print
	@echo
	@echo -- ENV --
	@echo ENV_SOURCE: $(ENV_SOURCE)
	@echo ENV_TEMPLATE: $(ENV_TEMPLATE)
	@echo ENV_TARGET: $(ENV_TARGET)
	@echo


## Installs any things the env needs
env-dep: ## env-dep
	# installs the things needed to the os.
