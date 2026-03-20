#!/bin/bash

set -e

DB_NAME=${DB_NAME:-mydb}
DB_USER=${DB_USER:-admin}

BACKUP_DIR="backups"
mkdir -p "$BACKUP_DIR"

FILENAME="${BACKUP_DIR}/backup_$(date +"%Y%m%d_%H%M").sql"

echo "Tworzenie backupu: $FILENAME"

docker compose exec -T db pg_dump -U "$DB_USER" "$DB_NAME" > "$FILENAME"

echo "Backup zapisany: $FILENAME"

echo "Usuwanie backupów starszych niż 7 dni..."
find "$BACKUP_DIR" -type f -mtime +7 -delete

echo "Gotowe!"