.PHONY: all
.NOTPARALLEL:

docker.build: .PHONY
	docker build -t "${DOCKER_IMAGE}:${DOCKER_TAG}" .

docker.push: .PHONY
	docker push "${DOCKER_IMAGE}:${DOCKER_TAG}"
