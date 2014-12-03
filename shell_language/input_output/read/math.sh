#!/bin/bash


for n in 9 8 7 6 5 4 3 2 1 0
     do
	for m in  9 8 7 6 5 4 3 2 1 0
		do
			for s in 9 8 7 6 5 4 3 2 1 0
			do
				if [ $(($n$m$s%11)) -eq 0 ]
				then
					if [ $(($n+$m+$s)) -eq 17 ]
					then
					
						printf "$n$m$s \t"
		 			#	printf  "$(($n+$m)) \t"
					fi
				fi
			done
	done
done
		 
