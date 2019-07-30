#!/usr/bin/make

SHELL := /bin/sh
REGISTRY_HOST = docker.io
USERNAME = kosar
REPOSITORY = varnish
IMAGE := $(REGISTRY_HOST)/$(USERNAME)/$(REPOSITORY)
DOCKER_FILE = Dockerfile
VARNISH_DL := https://varnish-cache.org/_downloads/varnish-
docker_bin := $(shell command -v docker 2> /dev/null)
textred := \033[0;31m
textnormal := \033[0m

.PHONY : build clean help login new pull push run stop shell
.DEFAULT_GOAL := help

ifeq (build,$(firstword $(MAKECMDGOALS)))
  TAG := $(word 2, $(MAKECMDGOALS))
  $(eval $(TAG):;@:)
endif
ifeq (create-tag,$(firstword $(MAKECMDGOALS)))
  TAG := $(word 2, $(MAKECMDGOALS))
  $(eval $(TAG):;@:)
endif
ifeq (create-tag,$(firstword $(MAKECMDGOALS)))
  NEWTAG := $(word 3, $(MAKECMDGOALS))
  $(eval $(NEWTAG):;@:)
endif
ifeq (new,$(firstword $(MAKECMDGOALS)))
  TAG := $(word 2, $(MAKECMDGOALS))
  $(eval $(TAG):;@:)
endif
ifeq (pull,$(firstword $(MAKECMDGOALS)))
  TAG := $(word 2, $(MAKECMDGOALS))
  $(eval $(TAG):;@:)
endif
ifeq (push,$(firstword $(MAKECMDGOALS)))
  TAG := $(word 2, $(MAKECMDGOALS))
  $(eval $(TAG):;@:)
endif
ifeq (run,$(firstword $(MAKECMDGOALS)))
  TAG := $(word 2, $(MAKECMDGOALS))
  $(eval $(TAG):;@:)
endif
ifeq (shell,$(firstword $(MAKECMDGOALS)))
  TAG := $(word 2, $(MAKECMDGOALS))
  $(eval $(TAG):;@:)
endif
ifeq (stop,$(firstword $(MAKECMDGOALS)))
  TAG := $(word 2, $(MAKECMDGOALS))
  $(eval $(TAG):;@:)
endif

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Build Docker image Usage: $ make build "tag"
	if [ -d "./$(TAG)" ]; then \
	  $(docker_bin) build -t $(IMAGE):$(TAG) -f ./$(TAG)/$(DOCKER_FILE) ./$(TAG); \
	else \
  	echo "\n $(textred) Can't find this version locally. You should use key \"new\" to create new tag. $(textnormal)";  \
	fi

create-tag: ## Remove images from local registry. Usage: $ make create-tag "existing-tag" "new-tag"
	if [ -d "./$(TAG)" ]; then \
	  $(docker_bin) tag $(IMAGE):$(TAG) $(IMAGE):$(NEWTAG); \
	else \
  	echo "\n $(textred) Can't find this version locally. You should use key \"new\" to create new tag. $(textnormal)";  \
	fi

clean: ## Remove images from local registry. Usage: $ make clean
	$(docker_bin) ps -a | awk -F "\t" '{ print $$1,$$7 }' | grep "varnish-test-" | awk '{print $$1 }' | xargs -I {} $(docker_bin) rm -f {} ; \
	$(docker_bin) rmi -f `$(docker_bin) images -q $(USERNAME)/$(REPOSITORY)`
login: ## Log in to a remote Docker registry. Usage: $ make login
	$(docker_bin) login $(REGISTRY_HOST)

new: ## Create new tag from template. DANGER! EXPERIMENTAL! Usage: $ make new "tag". You can see all tags here: https://varnish-cache.org/releases/index.html
	echo "\n $(textred) DANGER! EXPERIMENTAL FUNCTION! $(textnormal)"; \
	if [ -d "./$(TAG)" ]; then \
	  echo "\n $(textred) Files for this version exists locally. You should use key \"build\" for it. $(textnormal)";  \
	else \
	  if [ "$$(curl -o /dev/null --silent --head --write-out '%{http_code}' $(VARNISH_DL)$(TAG).tgz)" = "200" ]; then \
		  cp -R ./tpl ./$(TAG); \
			sed -i "s/!!VERSION!!/$(TAG)/g" ./$(TAG)/$(DOCKER_FILE); \
			$(docker_bin) build -t $(IMAGE):$(TAG) -f ./$(TAG)/$(DOCKER_FILE) ./$(TAG); \
    else \
		  echo "\n $(textred) This version of varnish is not found! Check vesion number, please. $(textnormal)"; \
  	fi; \
	fi

pull: ## Pull specific tag from the registry. Usage: $ make pull "tag".
	$(docker_bin) pull $(IMAGE):$(TAG)

push: ## Pull specific tag from the registry. Usage: $ make push "tag".
	$(docker_bin) push $(IMAGE):$(TAG)

run: ## Start varnish comtainer for test with test parameters. In other case you need to run command manually! Usage: $ make run "tag".
	$(docker_bin) run -itd -e VARNISH_BACKEND_ADDRESS=192.168.66.14 --name=varnish-test-$(TAG) kosar/varnish:$(TAG)

stop: ## Stop and remove container. Usage: $ make stop "tag".
	$(docker_bin) ps -a | awk -F "\t" '{ print $$1,$$7 }' | grep "varnish-test-$(TAG)" | awk '{print $$1 }' | xargs -I {} $(docker_bin) rm -f {}

shell: ## Start shell into varnish container. Usage: $ make shell "tag".
	$(docker_bin) exec -it varnish-test-$(TAG) sh
