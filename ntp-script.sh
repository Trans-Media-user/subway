#!/bin/bash
while (true)
do
	if ping -c 1 172.16.222.254 >> /dev/null 2>&1;
	then
		ntpdate -u 172.16.222.254;
		sleep 3600
	else
	echo 'No connect to host'
	fi
	sleep 10
done
