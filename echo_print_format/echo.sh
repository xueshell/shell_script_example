#!/bin/bash

for (( i=9090; i<999999 ; i++))
do
	if (("$i"%9==0)) 
	then
		echo -n $i
		echo -n " "
		#echo -n 0
		#echo -n " "
	else
		echo -n N
		echo -n " "
	fi
done
