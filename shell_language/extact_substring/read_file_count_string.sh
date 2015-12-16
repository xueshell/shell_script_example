#!/bin/bash
i=0
while read LINE
do
	echo $LINE
	((i++))
	echo $i
	
	for ((n=1;n<${#LINE};n++))
	do
		echo ${LINE:n}
		echo "" 

	done

done</data0/largefile.random.txt
