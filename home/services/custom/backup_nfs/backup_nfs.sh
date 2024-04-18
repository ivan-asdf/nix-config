#!/bin/sh

# Source and destination folders
source_folder="$HOME/nfs"
destination_folder="$HOME/tosh_hdd/nfs_backup"

# Log file
log_file="$HOME/tosh_hdd/.nfs_backup/nfs_backup.log"

# Backup folder(to have backup of deleted files)
timestamp=$(date +'%Y%m%d_%H%M%S')
backup_dir="$HOME/tosh_hdd/.nfs_backup/$timestamp"

# Run rsync with options to preserve permissions and record deleted files
rsync \
  -av --delete \
  --log-file="$log_file" --backup --backup-dir="$backup_dir" \
  "$source_folder/" "$destination_folder/"

echo "Backup completed successfully."

