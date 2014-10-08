#!/bin/bash
declare -a NAME 
n=0

find . -type f | while read file
do
	
	
      	NAME[$n]=$(md5sum $file | cut -d ' ' -f1 )
	n=$((n+1))	
done

echo ${NAME[4]}
