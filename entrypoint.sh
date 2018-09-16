#!/bin/sh

github-backup -u ${GITHUB_USER} -t ${GITHUB_TOKEN} \
	--incremental --private --gists --fork --all --bare --lfs \
	-o /backup \
	${GITHUB_BACKUP_USER}