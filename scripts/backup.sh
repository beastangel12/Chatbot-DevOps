#!/usr/bin/env bash
BACKUP_DIR=/home/ubuntu/backups/$(date +%F)
mkdir -p $BACKUP_DIR
tar -czf $BACKUP_DIR/app-files.tar.gz -C /home/ubuntu project || true
# keep last 7 backups
cd /home/ubuntu/backups || exit
ls -1d */ | sort -r | sed -n '8,$p' | xargs -r rm -rf
