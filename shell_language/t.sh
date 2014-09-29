#! /bin/bash
declare -a ARR
n=0
find . -type f | while read file
do
	n=$((n+1))	
#	echo -n "$file  "
	#echo  "$file  "
	#echo $n
      	ARR[$n]=$(md5sum "$file"|cut -d ' ' -f1)
#	md5sum "$file"|cut -d ' ' -f1|tr '\n' ' '
#	sha1sum "$file"|cut -d ' ' -f1
	#done >> /home/ftp_get/list.txt
#done >list.txt
done

echo ${ARR[@]}
