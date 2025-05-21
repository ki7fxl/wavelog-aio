#!/bin/bash

podman run -d \
    --name wavelog \
    -v wavelog-db:/var/lib/mysql \
    -v wavelog-config:/app/application/config/docker \
    -v wavelog-uploads:/app/application/uploads \
    -v wavelog-userdata:/app/application/userdata \
    -p 8080:80 \
    -p 9001:9001 \
    -e "DATABASE_PASSWORD=wavelog" \
    wavelog:latest
