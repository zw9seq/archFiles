#! /bin/bash

# Gets date of most recent backup.    
newestfile=$(find /back/backups/ -type f -printf '%T@ %p\n' | sort -n | tail -1 | cut -f2- -d" ")        
budate=$(echo "$newestfile"| cut -c22-31)

# Gets current date
cdate=$(date --iso)

# Compare dates
if [ "$cdate" = "$budate" ]
then
    notify-send "Backup Status" "There is yet a backup from today."
else
    notify-send "Backup Status" "Today's backup started."

    #MODIFY THIS# tar -cpzf /[YourBackupStorage]/backup-"$cdate".tar.gz /[Directory1] /[Directory2] ...
    
    notify-send --expire-time=60000 "Backup Status" "Today's backup finished."
fi
