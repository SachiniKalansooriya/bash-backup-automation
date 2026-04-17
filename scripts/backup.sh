#!/bin/bash
#AUtomated Backup script with rotation
#Backs up source-files folder and keeps only last 7 backups

DATE=$(date '+%Y-%m-%d_%H-%M-%S')
SOURCE="source-files"
DEST="backups"
BACKUP_FILE="$DEST/backup_$DATE.tar.gz"
LOG="logs/backup.log"
MAX_BACKUPS=7

mkdir -p $DEST
mkdir -p logs

echo "Backup Started: $DATE"

#check source exists
if [ ! -d "$SOURCE" ]; then 
echo "ERROR: Source folder $SOURCE not found!"
echo "[$DATE] ERROR: Source folder not found" >> $LOG
exit 1
fi

#create backup
echo "Backing up: $SOURCE"
tar -czf $BACKUP_FILE $SOURCE

if [ $? -eq 0 ]; then
SIZE=$(du -sh $BACKUP_FILE | awk '{print $1}')
echo "Backup created: $BACKUP_FILE ($SIZE)"
echo "[$DATE] SUCCESS: $BACKUP_FILE ($SIZE)" >> $LOG
else
echo "ERROR:Backup failed!"
echo "[$DATE] ERROR: BACKUP FAILED" >> $LOG
exit 1
fi

#rotation- keep only last 7 backups
BACKUP_COUNT=$(ls $DEST/backup_*.tar.gz 2>/dev/null | wc -l)
echo "Total backups: $BACKUP_COUNT"

if [ $BACKUP_COUNT -gt $MAX_BACKUPS ]; then
echo "Removing old backups - keeping las $MAX_BACKUPS"
ls -t $DEST/backup_*.tar.gz | tail -n +$((MAX_BACKUPS + 1)) | xargs rm -f 
echo "[$DATE] ROTATION: removed old backups" >> $LOG
fi

echo ""
echo "current backups:"
ls -lh $DEST/backup_*.tar.gz 2>/dev/null
echo ""
echo "backup complete! Log: $LOG"
