#!/bin/bash

mkdir -p backups

running=$(podman inspect -f '{{.State.Running}}' wavelog)
if [ $running = "true" ]; then
    echo "Backing up SQL database..."
    podman exec -i wavelog mysqldump -uroot wavelog > "backups/wavelog_$(date +%Y%m%d_%H%M%S).sql"
    echo "Stopping wavelog container..."
    podman stop wavelog >/dev/null
fi
podman run --rm -i \
    -v ./backups:/backups \
    -v wavelog-uploads:/wavelog/wavelog-uploads \
    -v wavelog-userdata:/wavelog/wavelog-userdata \
    -v wavelog-config:/wavelog/wavelog-config \
    -v wavelog-db:/wavelog/wavelog-db \
    alpine:latest /bin/sh <<EOF
echo "Backing up Wavelog volumes..."
cd /wavelog
tar cvfz "/backups/wavelog_backup_$(date +%Y%m%d_%H%M%S).tar.gz" . >/dev/null
EOF

if [ $running = "true" ]; then
    echo "Restarting wavelog..."
    podman start wavelog >/dev/null
fi

echo "Backup complete."