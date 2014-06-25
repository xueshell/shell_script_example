#!/bin/bash
# Server Monitoring Script
# authors: Roman Usiatycki, Christian Weuste

#HOST="http://www.michgibtsnicht.com"
#HOST="http://www.gm.fh-koeln.de"
HOST="http://10.55.37.64:8810/signin"

THRESHOLD=4 #Schwellenwert, ab dem der Webserver als DOWN gilt
OPTIONS="-S -q -O -"
#LOGFILE=/home/christian/Desktop/servmon.log
LOGFILE=/tmp/christian/Desktop/servmon.log
DELTA=6

#rm $LOGFILE

LASTCALLTIME=$(date +%s)

while true
do
NOW=$(date +%s)
    TIMEDIFF=$(( $NOW - $LASTCALLTIME ))
    if [ $TIMEDIFF -ge $DELTA ]; then
LASTCALLTIME=$(date +%s)
        RESPONSE=`wget $HOST $OPTIONS | awk '/^ HTTP/{print \$2}'`
        echo $LASTCALLTIME >> $LOGFILE
        echo $LASTCALLTIME
        echo $RESPONSE
    fi
done

