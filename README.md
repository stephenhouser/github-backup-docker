# Sync Git Repositories (with LFS)

Docker container to update local git repositories from their remotes.
Calls `git fetch --all` on all repositories in `data` directory to 
download any changes from all remotes to the local volume.

This container does not *synchronize* or *back up* anything, it merely fetches any updates. It does not *push* anything to the remotes, nor does it maintain snapshots of the data. If the remote is corrupt, then likely this will just fail.

This is used, by me, to keep a local archive of all my GitHub repositories on a local device. I use a separate system to make regular snapshots to avoid corruption.

```
for each repo in /data
	fetch all from origin
	clean, prune, etc.
```

# Repository Setup

You need to clone all your remote repositories into the `data` directory outside of this container first. This container will only fetch known repositories from their known remotes.

Example:
```
cd ~/git-clones
git clone --bare ssh://git@github.com:stephenhouser/docker_git_fetch.git
```

If you need an *SSH key* to access your repositories, simply copy that key into a file named `private-key` in the `data` directory:

```
cp ~/.ssh/id_rsa ~/git-clones/private-key
```

# Repository Update

To fetch all the remotes, run the container

Example:
```
docker run --rm -v $(pwd)/data:/data stephenhouser/git_fetch
```

