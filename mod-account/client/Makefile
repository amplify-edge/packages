current_dir = $(shell pwd)
I18N_DIR = $(current_dir)/i18n
I18N_LOCALIZATION_DIR = $(current_dir)/lib/core/i18n
I18N_GENERATED_DIR = $(I18N_LOCALIZATION_DIR)/generated
I18N_TEMPLATE_NAME = intl_messages.arb
I18N_TEMPLATE_PATH = $(I18N_DIR)/$(I18N_TEMPLATE_NAME)
I18N_PREFIX_OUT_FILES = lang

help: ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf " \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

## LANG
# 0. make lang-dep => ensure you have the i18n tool
# 1. make lang-gen-flu => generate all files

lang-dep: ## lang-dep
	go get -u github.com/getcouragenow/bootstrap/tool/i18n

# If you want the .dart files generated, add this to the bottom of the command
#flutter pub run intl_translation:generate_from_arb --output-dir=$(I18N_GENERATED_DIR) $(I18N_LOCALIZATION_DIR)/translations.dart $(I18N_DIR)/*.arb
lang-gen-flu: ## lang-gen-flu
	@mkdir -p $(I18N_GENERATED_DIR)
	@mkdir -p $(I18N_DIR)
	@flutter pub run intl_translation:extract_to_arb --output-dir=$(I18N_DIR) $(I18N_LOCALIZATION_DIR)/translations.dart
	@i18n flutter --dir $(I18N_DIR) --template $(I18N_TEMPLATE_PATH) --prefix $(I18N_PREFIX_OUT_FILES) --languages en,fr,es,ur -f
	@i18n flutter --dir $(I18N_DIR)
