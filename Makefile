# ==============================================================================
# Includes

include scripts/make-rules/common.mk
include scripts/make-rules/kind.mk

# ==============================================================================
# Usage


# help: Makefile
# 	@echo -e "\nUsage: make ...\n\nTargets:" 
# 	@sed -n 's/^##//p' $< | column -t -s ':' | sed -e 's/^/ /' 
# 	@echo "$$USAGE_OPTIONS"

##@ General
.PHONY: help echo

help: ## Display this help.
	@awk 'BEGIN\
		 {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} \
		 /^[a-zA-Z_0-9-]+[.\/_-]?[a-zA-Z_0-9-]*[.\/_-]?[a-zA-Z_0-9-]+:.*?##/ \
		 { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } \
		 /^##@/ \
		 { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } \
		 ' $(MAKEFILE_LIST)
