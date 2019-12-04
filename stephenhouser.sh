#!/bin/bash
source stephenhouser.env
docker run --rm \
	-v /share/Backup/GitHub/stephenhouser:/backup \
	-e GITHUB_USER=${GITHUB_USER} \
	-e GITHUB_TOKEN=${GITHUB_TOKEN} \
	-e GITHUB_BACKUP_USER=${GITHUB_BACKUP_USER} \
	github-backup
