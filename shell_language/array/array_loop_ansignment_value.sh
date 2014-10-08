#!/bin/bash
declare -a NAME 
FName=""
FPath=""
Md5value=""
FList=$(find . -type f )
n=0
m=0
while read file
do
	
	FName=$( basename $file )
	FPath=$( dirname $file )	
      	Md5value=$(md5sum $file | cut -d ' ' -f1 )
      	NAME[$n]="$FName,$FPath,$Md5value"
	n=$(($n+1))	
done<<EOF
$FList
EOF



while(( m<${#NAME[@]} ))
do
	echo ${NAME[m]}
	m=$(($m+1))
done
