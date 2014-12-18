#!/bin/bash

curl http://10.79.96.250/pub_check/view.php?check_uuid=1415948470.240327941 >/tmp/$$ 

#cat /tmp/$$ | awk 'BEGIN { FS="\n"; } { print $2 }'


while  read LINE 
do
 	echo $LINE | awk ' BEGIN { FS = "+"; ORS = "\n"   }  { print $3 } '| awk 'ORS=NR%20?"\t":"\n"'
#echo $LINE | awk ' BEGIN { FS = "+"; ORS = ";   "   }  { print $4 } '
#awk 'ORS=NR%20?"\t":"\n"'
done </tmp/$$ 

rm -f /tmp/$$
