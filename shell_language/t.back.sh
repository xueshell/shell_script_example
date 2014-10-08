#!/bin/bash
export declare -a NAME 
n=0

find . -type f | while read file
do
#	echo $file
	
#	echo -n "$file  "
	#echo  "$file  "
#	echo $n
	
      	NAME[$n]=$(md5sum $file | cut -d ' ' -f1)
	echo ${NAME[$n]} >/dev/null
	n=$((n+1))	
#	md5sum "$file"|cut -d ' ' -f1|tr '\n' ' '
#	sha1sum "$file"|cut -d ' ' -f1
	#done >> /home/ftp_get/list.txt
#done >list.txt
done

#echo --------
#echo ${NAME[10]}
echo ${NAME[3]}
