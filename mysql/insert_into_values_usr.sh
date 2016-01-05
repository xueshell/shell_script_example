#!/bin/bash

mkdir -p /data0/MN ; cd /data0/MN
for M in {a..z}
do
	for N in {A..Z}
	do
		#echo $M$N
		mkdir $M$N
	
	done
done
wc -l
