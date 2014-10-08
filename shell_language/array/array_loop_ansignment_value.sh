#!/bin/bash
declare -a NAME 
n=0
FList=$(find . -type f )

while read file
do
	
	
      	NAME[$n]=$(md5sum $file | cut -d ' ' -f1 )
	n=$((n+1))	
done<<EOF
$FList
EOF

echo ${NAME[4]}
echo ${NAME[8]}
echo ${NAME[9]}
