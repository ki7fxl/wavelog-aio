#!/bin/bash

podman kill wavelog
podman rm wavelog
podman rmi wavelog
podman volume rm wavelog-db
podman volume rm wavelog-config
podman volume rm wavelog-uploads
podman volume rm wavelog-userdata