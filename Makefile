BIN=./node_modules/.bin

WEBPACK=$(BIN)/webpack
WEBPACK_SERVER=$(BIN)/webpack-dev-server

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: ## Install deps
	bundle install
	npm install
	@echo 'Done! <3 <3 <3'

start: ## Start the frontend dev server
	NODE_ENV=development $(WEBPACK_SERVER) --hot --inline --content-base src/, --no-info --colors

build: ## Compile the app for production
	rm -rf dist
	NODE_ENV=production $(WEBPACK) -p

.PHONY: \
	install \
	start \
	build \
	help
