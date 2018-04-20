#
# git-fetch - Fetch all remotes for git repositories
#
VM_NAME=git_fetch
DOCKER_IMAGE=stephenhouser/git_fetch
DATA_VOLUME=$(shell pwd)/data

#include ../makefile.vars

ls:
	-@docker ps -a | grep ${VM_NAME} || echo "No container named: ${VM_NAME}"
	-@docker volume ls | grep ${DATA_VOLUME} || echo "No volume(s) named: ${DATA_VOLUME}"

build:
	docker build -t ${DOCKER_IMAGE}:latest .

run: build
	@echo "Creating container ${VM_NAME}..."
	docker run --rm \
		--name ${VM_NAME} \
		-v ${DATA_VOLUME}:/data \
		${DOCKER_IMAGE}

start:
	@echo "Starting container ${VM_NAME}..."
	-@docker ps -a | grep ${VM_NAME} && docker start ${VM_NAME}

attach:
	-@docker ps -a | grep ${VM_NAME} && docker exec -it ${VM_NAME} /bin/sh

console:
	-@docker ps -a | grep ${VM_NAME} && docker attach ${VM_NAME}

stop:
	@echo "Stopping container ${VM_NAME}..."
	-@docker ps -a | grep ${VM_NAME} && docker stop ${VM_NAME}

clean: stop
	@echo "Removing container ${VM_NAME}..."
	-@docker ps -a | grep ${VM_NAME} && docker rm ${VM_NAME}

distclean: clean clean-volume
	@echo "Cleaning up volumes and images..."
	-@docker volume prune -f
	-@docker image prune -f
