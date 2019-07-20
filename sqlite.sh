#!/bin/bash
sqlite3 /home/subway/sdcard/metro.db <<EOS
DELETE FROM "event_log" WHERE "time_stamp" <= date('now','-30 day'); 
EOS
