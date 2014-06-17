#!/bin/bash
for m in 9 8 7 6 5 4 3 2 1 0
do
	for n in 9 8 7 6 5 4 3 2 1 0
	do
		a=$(($m$n%3))
		b=$(($m$n%4))
		c=$(($m$n%5))
		if [ $(($a+$b+$c)) -eq 8 ]
		then
			printf "$m$n \t"
		fi
	done
done
