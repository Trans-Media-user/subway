#!/bin/bash
while true
do
FTP_PATH=/home/subway/ftp/export/lines_source/
LINES_SOURCE=/home/subway/sdcard/video/lines_source/
SDCARD=/home/subway/sdcard/
	for timestamp in `find $FTP_PATH -type f -name "timestamp"`;
	do
	TIMESTAMP=$(cat $timestamp | cut -c 1-19);
	done
TIME=$(date +"%d-%m-%Y %H:%M:%S");
	if [[ "$TIME" > "$TIMESTAMP" ]]
	then
		for new_clip in `find $FTP_PATH -type f -name "*.ts"`;
		do
			filename=$(basename -- "$new_clip")
			extension="${filename##*.}"
			filename="${filename%.*}"
			FILE_SUM=$(find $FTP_PATH -type f -name "$filename.md5");
			SUM_MD5=$(cat $FILE_SUM | cut -c 1-32);
			SUM_NEW_FILE=$(md5sum $new_clip | cut -c 1-32);
			OLD_CLIP=$(find $LINES_SOURCE -type f -name "$filename.ts");
			SUM_OLD_FILE=$(md5sum $OLD_CLIP | cut -c 1-32);
			echo -e "$SUM_MD5 \n $SUM_NEW_FILE"
				if [ "$SUM_MD5" == "$SUM_NEW_FILE" ]
					then
						if [ "$SUM_OLD_FILE" != "$SUM_NEW_FILE" ]
							then mv -f $new_clip $LINES_SOURCE;
							echo "$TIME $new_clip $SUM_NEW_FILE" >> /home/subway/ftp/import/lines_source_log
							else echo "same file"
							fi
					else rm $new_clip
					fi 
				done
		else echo "to early"
		fi
		for settings in `find $FTP_PATH -type f -name "settings.txt"`;
			do
				for settings_old in `find $SDCARD -type f -name "settings.txt"`;
					do
					SUM_SETTINGS_NEW=$(md5sum $settings | cut -c 1-32);
					SUM_SETTINGS_OLD=$(md5sum $settings_old | cut -c 1-32);
						if [ "$SUM_SETTINGS_NEW" != "$SUM_SETTINGS_OLD" ]
							then mv -f $settings $SDCARD
							echo "$TIME $settings $SUM_SETTINGS_NEW" >> /home/subway/ftp/import/lines_source_log
							else echo "same file"
						fi
				done
			done
			sleep 600
			done
