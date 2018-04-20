# Sync Git Repositories (with LFS)

Docker container to update local git repositories from their remotes.
Calls `git fetch --all` on all repositories in `data` directory to
download any changes from all remotes to the local volume.

Does not completely handle `git-lfs` files yet.

This container does not *synchronize* or *back up* anything, it merely fetches any updates. It does not *push* anything to the remotes, nor does it maintain snapshots of the data. If the remote is corrupt, then likely this will just fail.

This is used, by me, to keep a local archive of all my GitHub repositories on a local device. I use a separate system to make regular snapshots to avoid corruption.

```
for each repo in /data
	fetch all from origin
	clean, prune, etc.
```

# *** BUG ***

LFS repos cannot be *bare* local directory repos at the moment [See this issue](https://github.com/git-lfs/git-lfs/issues/2342). You need a server to mirror LFS.

Workaround: make a regular clone with the `.git` extension:
```
git clone git@github.com:stephenhouser/lfs-example.git lfs-example.git
```

This makes a local copy, but you cannot clone it properly, you get LFS fetch failures. The LFS stuff fails. It also makes a non-bare repository and the "checked out" branch is not updated, only the history is fetched. Not entirely sure this works properly.

You need a server to [Mirror a repository that contains Git Large File Storage objects](https://help.github.com/enterprise/2.8/user/articles/duplicating-a-repository/#mirroring-a-repository-that-contains-git-large-file-storage-objects)


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

