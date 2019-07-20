#! /bin/bash
cp -f /home/subway/sdcard/metro.db /home/subway/ftp/import/
cp -f /home/subway/ftp/export/script/script.sh /home/subway/script/
sleep 100
fstrim /;
sleep 20
fstrim /home/;
cd /home/subway/script/
chown subway:subway script.sh
chmod 770 script.sh
. ./script.sh
exit 0
