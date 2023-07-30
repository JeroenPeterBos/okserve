.DEFAULT_GOAL := help


#######################
### QUALITY CONTROL ###
#######################

.PHONY: test
test:  ## Run tests
	poetry run pytest


.PHONY: format
format:  ## Format code
	poetry run black .
	poetry run isort .

##############################
### ENVIRONMENT MANAGEMENT ###
##############################

.PHONY: depdev
depdev:  ## Add a development dependency
	@read -p "Enter the name of the dependency: " dep; \
	poetry add $$dep --group=dev

.PHONY: dep
dep:  ## Add a dependency
	@read -p "Enter the name of the dependency: " dep; \
	poetry add $$dep

##########################
### RELEASE MANAGEMENT ###
##########################

.PHONY: version
version:  ## Bump the version
	@read -p "Enter the semantic bump type (major.minor.patch): " version; \
	poetry version $$version

.PHONY: build
build:  ## Build the package
	poetry build

.PHONY: publish
publish:  ## Publish the package
	poetry publish --build

##########################
### AUTO DOCUMENTATION ###
##########################

## Width of the command text in the help message
COMMAND_TEXT_WIDTH=17
help: ## Show this help message
	@printf "\033[1;31mProject Maintenance Commands\033[0m\n\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-${COMMAND_TEXT_WIDTH}s \033[0m %s\n", $$1, $$2}'
