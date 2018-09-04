#
# GitHub Backup - Backup GitHib repositories
#
# Based on github-backup from https://github.com/josegonzalez/python-github-backup
#
# Include my secrets from a protected place
include ~/.ssh/container-secrets.txt

# Basic container setup
VM_NAME=$(shell /usr/bin/awk '/container_name: / {print $$2;}' docker-compose.yaml)

.PHONY: default backup test

# Show the container and its volumes
default:
	docker-compose ps

# Back up the container's data by exporting and compressing it
backup:
	docker-compose run --rm github-backup

## Make a new container by restoring an existing database
#restore: distclean
#	#docker-compose up --no-start
#
test:
	docker-compose run --rm github-backup /bin/sh

# Make (and start) the container
run: backup

container:
	docker-compose build

# # Start an already existing container that has been stopped
# start:
# 	docker-compose start

# Attach to a running contiainer with sh
attach:
	docker run --rm -it --name ${VM_NAME} ${VM_NAME} /bin/sh
#	docker exec -it ${VM_NAME} /bin/sh

# # Attach to a running container's console
# console:
# 	screen -d -R -S ${VM_NAME} docker attach ${VM_NAME}

# # Stop a running container
# stop:
# 	docker-compose stop

# Update a container's image; stop, pull new image, and restart
update: clean
	-docker-compose pull ${DOCKER_IMAGE}
	make container 

# Delete container's volume (DANGER)
clean-volume:
	docker-compose down -v

# Delete a container (WARNNING)
clean: stop
	docker-compose down

# Delete a container and it's volumes (DANGER)
distclean: clean clean-volume
