# help
.DEFAULT_GOAL       := help
HELP_TARGET_MAX_CHAR_NUM := 20

HELP_GREEN  := $(shell tput -Txterm setaf 2)
HELP_YELLOW := $(shell tput -Txterm setaf 3)
HELP_WHITE  := $(shell tput -Txterm setaf 7)
HELP_RESET  := $(shell tput -Txterm sgr0)

help:  ## Display this help

	@echo ''
	@echo 'Usage:'
	@echo '  ${HELP_YELLOW}make${HELP_RESET} ${HELP_GREEN}<target>${HELP_RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${HELP_YELLOW}%-$(HELP_TARGET_MAX_CHAR_NUM)s${HELP_RESET} ${HELP_GREEN}%s${HELP_RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)