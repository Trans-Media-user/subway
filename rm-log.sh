#! /bin/bash
i=30
find /home/subway/ftp/import/ -type f -mtime +$i -exec rm -f {} \;
find /home/subway/ftp/export/clips/ -type f -mtime +$i -exec rm -f {} \;
exit 0
