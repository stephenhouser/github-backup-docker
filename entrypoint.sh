#!/bin/sh

github-backup -u ${GITHUB_USER} -t ${GITHUB_TOKEN} \
	--incremental --all --fork --bare --lfs --gists \
	-o /backup \
	${GITHUB_BACKUP_USER}