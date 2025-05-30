#!/bin/bash

backupfile="$1"

if [ ! -f "$backupfile" ]; then
    echo "File $backupfile doesn't exist"
    exit 1
fi

running=$(podman inspect -f '{{.State.Running}}' wavelog 2>/dev/null)
if [ "$running" = "true" ]; then
    echo "Stopping wavelog container..."
    podman stop wavelog
fi

podman volume rm wavelog-{config,db,userdata,uploads} 2>/dev/null

podman run --rm -i \
    -v $(realpath $backupfile):/backup.tar.gz \
    -v wavelog-uploads:/wavelog/wavelog-uploads \
    -v wavelog-userdata:/wavelog/wavelog-userdata \
    -v wavelog-config:/wavelog/wavelog-config \
    -v wavelog-db:/wavelog/wavelog-db \
    alpine:latest /bin/sh <<EOF
cd /wavelog
tar xfvz /backup.tar.gz >/dev/null
EOF

if [ "$running" = "true" ]; then
    echo "Restarting wavelog..."
    podman start wavelog
fi