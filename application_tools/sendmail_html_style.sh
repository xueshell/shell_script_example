#!/bin/bash
#send a html-email using sendmail command
#author:
#license:GPL

from="my@mydomain.com"
subject="test html-email using mail command"
msgdate=`date +"%a, %e %Y %T %z"`  # Leave alone
emailtarget="your@yourdomain.com"

daemail=$(cat <<!
Date: $msgdate
From: $from
To:$emailtarget
Subject: $subject
Mime-Version: 1.0
Content-Type: text/html; charset=gb2312
!)

echo "$daemail" > msg.tmp
echo >>msg.tmp
cat test.html >>msg.tmp
echo  >> msg.tmp
cat msg.tmp |sendmail -t
rm -f msg.tmp 
