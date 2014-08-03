#!/bin/bash
#simple log rotation script, add to cron tab to make it automatic

#change to the correct directory with the logs
cd /Users/forzaglia/Documents/test

#set var to the extension refelcting the current date and time to append to the gzipped log
ext=`date +%Y-%m-%d-%H:%M-%Z`

#gzip the active log into a new gz file with the correct extension
gzip -c SysOut.log>SysOut.log.$ext.gz

#null the active log to clear the contents
>SysOut.log

#find the number of gzipped logs in the directory
count=`ls -lr | grep .log. | wc -l`

#remove the 2 oldest gzipped logs if the count is greater than 10
if  [ $count -gt 10 ]; then

    ls -lt | grep .log. | awk '{print $10 ;}' | tail -2 | xargs rm
fi

#send email after rotation
subject="AUTO: SysLog -- $ext"
email="thomas.forzaglia@mlb.com"
body="/Users/forzaglia/Documents/test/emailmessage.txt"
echo "Automatic log rotation has been performed in the /Users/forzaglia/Documents/test path."> $body
/usr/bin/mail -s "$subject" "$email" < $body
