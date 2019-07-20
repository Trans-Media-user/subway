#!/bin/bash
folder_export=/home/subway/ftp/export/clips
folder_import=/home/subway/ftp/import/
folder_lines=/home/subway/ftp/export/lines_source/
folder_script=/home/subway/ftp/export/script/
folder_remote_export=/Kh35u/export/
folder_remote_import=/Kh35u/import/
folder_remote_lines=/Kh35u/lines_source/
folder_remote_script=/Kh35u/script/
ftp_server=172.16.222.254
ftp_user=Kh35u
ftp_password=GolovaKh35u

while (true)
do
  ret=$(ps aux | grep "lftp" | wc -l)
  if [ "$ret" -eq 1 ]; then
		# Perehodim v katalog zakachki
		cd $folder_export;

		#Proverka dostupnosti servera
		if ping -c 1 $ftp_server >> /dev/null 2>&1; then
			# Connect to FTP Server
			lftp -e "set net:timeout 5; set net:max-retries 2; set net:reconnect-interval-base 2;" $ftp_user:$ftp_password@$ftp_server <<_END_
			mirror --continue $folder_remote_export $folder_export
			mirror --continue $folder_remote_lines $folder_lines
			mirror --continue $folder_remote_script $folder_script
			mirror -R --continue $folder_import $folder_remote_import
_END_
		else
    	echo 'ERROR: No connect to host'
		fi
	else
		echo "EXIT. Script already running!"
	fi

	sleep 2
done
