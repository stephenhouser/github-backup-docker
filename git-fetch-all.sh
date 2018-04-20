#!/bin/sh

verbose=false
check=false

while getopts "vc" option; do
  case ${option} in
    v) verbose=true
       ;;
    c) check=true
       ;;
  esac
done
shift $((OPTIND -1))

if [ $# -ne 1 ]; then
	echo "git-fetch-all.sh: must specify a directory to scan for repositories"
	exit 1
fi

if [ ! -d $1 ]; then
	echo "git-fetch-all.sh: [$1] is not directory. Cannot scan."
	exit 2
fi

${verbose} && echo "Scanning: $1"

repos=$(find $1/ -type d -name \*.git | xargs)
for repo in $repos ; do
	cd $repo

	${verbose} && echo "Fetching remotes for $(pwd)"
	git fetch --all --quiet

	if ${check}; then
		${verbose} && echo "Checking $(pwd)"
		git fsck

		${verbose} && echo "Expiring unreachable objects"
		git reflog expire --expire-unreachable=now --all
		${verbose} && echo "Prune"
		git gc --prune=now
		${verbose} && echo "Rechecking $(pwd)"
		git fsck
	fi

	${verbose} && echo "done." && echo
done