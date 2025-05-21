wavelog-aio
-----------

This is a set of scripts to run and maintain a local self-contained [Wavelog](https://github.com/wavelog/wavelog) instance using podman (or docker).

## First steps

Build the container using `build.sh`. Then, populate a password of your choosing in `run.sh` for the database user, then run the script. Browse to http://localhost:8080 and run through the install wizard. Use `localhost` for database server and `wavelog` as username, with the password you set earlier as the password.

## Basic operation

- `build.sh`: Builds the container
- `run.sh`: Runs the container
- `stop.sh`: Stops the container (but does not delete it)
- `rm-container.sh`: Deletes the container (but not its volumes)
- `clear.sh`: Deletes the container, image, and volumes
- `backup.sh`: Creates a tar.gz file of all volumes
- `restore.sh`: Restores a tar.gz file into new volumes
- `shell.sh`: Drops into a shell in the running container