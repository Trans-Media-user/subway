#!/bin/bash
#echo "1) Депо Дарниця"
echo "2) Депо Оболонь"
echo "3) Депо Харкiвське"
read depo_name
case $depo_name in
#    1)
#    depo=D
#    echo "номер потяга"
#    read train
#    ;;
    2)
    depo=Ob
    echo "номер потяга"
    read train
    ;;
    3)
    depo=Kh
    echo "номер потяга"
    read train
    ;;
    *)
    echo "Даладна"
esac
echo "$depo"$train"u" > /etc/hostname
mkdir /home/subway/ftp/export/lines_source;
chown subway:subway /home/subway/ftp/export/lines_source;
chmod 750 /home/subway/ftp/export/lines_source;
cp -f sqlite.sh /home/subway/
cp -f line_source.sh /home/subway/
cp -f rm-log.sh /home/subway/
cp -f ntp-script.sh /home/subway/
cp -f boot_script.sh /home/subway/
cp -f mpss /home/subway/
cp -f dtmfstv /home/subway/
cp -f settings.txt /home/subway/sdcard/
cp -f ntp.conf /etc/
cp -f rc.local /etc/
chown subway:subway /home/subway/mpss
chown subway:subway /home/subway/dtmfstv
chown subway:subway /home/subway/sdcard/settings.txt
chmod 775 /home/subway/sdcard/settings.txt
chmod 775 /home/subway/mpss
chmod 775 /home/subway/dtmfstv
chown root:root /etc/rc.local
chmod 755 /etc/rc.local
chmod 750 /home/subway/*.sh;
mkdir /home/subway/ftp/export/script 
chown subway:subway /home/subway/ftp/export/script
chmod 770 /home/subway/ftp/export/script 
mkdir /home/subway/script
chown subway:subway /home/subway/script
chmod 770 /home/subway/script/
sed -i -e 's!folder_remote_export=/Kh35u/export/!folder_remote_export=/'${depo}''${train}u'/export/!' runftp.sh  
sed -i -e 's!folder_remote_import=/Kh35u/import/!folder_remote_import=/'${depo}''${train}u'/import/!' runftp.sh  
sed -i -e 's!folder_remote_lines=/Kh35u/lines_source/!folder_remote_lines=/'${depo}''${train}u'/lines_source/!' runftp.sh  
sed -i -e 's!ftp_user=Kh35u!ftp_user='${depo}''${train}u'!' runftp.sh  
sed -i -e 's!ftp_password=GolovaKh35u!ftp_password=Golova'${depo}''${train}u'!' runftp.sh 
sed -i -e 's!folder_remote_script=/Kh35u/script/!folder_remote_script=/'${depo}''${train}u'/script/!' runftp.sh 
cp -f runftp.sh /etc/metroftp/
chown subway:subway /etc/metroftp/runftp.sh
chmod 750 /etc/metroftp/runftp.sh
find /home/subway/ftp/export/clips/ -type f -exec rm -f {} \;
find /home/subway/sdcard/video/clips/ -type f -exec rm -f {} \;
find /home/subway/sdcard/download/video_clips/ -type f -exec rm -f {} \;
find /home/subway/ftp/firmware/ -type f -exec rm -f {} \;
cp -f 30228_update_855F540B5D0A11464122034D9D08D073.zip /home/subway/ftp/firmware/
chown subway:subway /home/subway/ftp/firmware/30228_update_855F540B5D0A11464122034D9D08D073.zip
chmod 770 /home/subway/ftp/firmware/30228_update_855F540B5D0A11464122034D9D08D073.zip
cp -f ./db/metro.db /home/subway/sdcard/
chown subway:subway /home/subway/sdcard/metro.db
chmod 644 /home/subway/sdcard/metro.db
cp -f ./db/db_template.sql /home/subway/sdcard/template/
chown subway:subway /home/subway/sdcard/template/db_template.sql
chmod 600 /home/subway/sdcard/template/db_template.sql
cp -f ./content/"$depo"/lines_source/*.ts /home/subway/sdcard/video/lines_source/
chown -R subway:subway /home/subway/sdcard/video/lines_source/
chmod -R 770 /home/subway/sdcard/video/lines_source/
cp -f ./content/"$depo"/drone+frv/*.ts /home/subway/sdcard/video/clips/
chown -R subway:subway /home/subway/sdcard/video/clips/
chmod -R 770 /home/subway/sdcard/video/clips/
cp -f ./content/"$depo"/ftp/* /home/subway/ftp/export/clips/
cp -f ./content/"$depo"/drone+frv/*.ts /home/subway/ftp/export/clips/
chown -R subway:subway /home/subway/ftp/export/clips/
chmod -R 770 /home/subway/ftp/export/clips/
echo "10000" > /home/subway/script/version
echo "c dtmf 31" | nc 10.1.1.1 3863
sleep 3
echo "c dtmf 29" | nc 10.1.1.1 3863
sleep 3
echo "c dtmf 34" | nc 10.1.1.1 3863
exit 0
