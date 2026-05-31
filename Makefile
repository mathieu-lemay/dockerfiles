MAKEFLAGS    += --always-make --warn-undefined-variables
SHELL        := /usr/bin/env bash
.SHELLFLAGS  := -e -o pipefail -c
.NOTPARALLEL :

DOCKER_BUILD_ARGS ?=

docker.build:
	docker build -t "${DOCKER_IMAGE}:${DOCKER_TAG}" $(DOCKER_BUILD_ARGS) .

docker.push:
	docker push "${DOCKER_IMAGE}:${DOCKER_TAG}"
