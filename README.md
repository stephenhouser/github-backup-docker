# GitHub Backup

Back up GitHub user account or organization to local directory.

The following environment variables need to be set somewhere. As I'm not using a container management system just yet, I use `~/.ssh/container-secrets.txt` which is in a relatively secure place for an individual. This file gets included in the `docker-compose.yaml` and my `makefile` as needed.

```
GITHUB_USER=Usename authenticate as
GITHUB_TOKEN=Token used for authentication
GITHUB_BACKUP_USER=user you want to make backup of
```