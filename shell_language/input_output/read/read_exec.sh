#!/bin/bash


echo "Enter file name"
read fname


if [ -z "$fname" ]
then
	exit
fi


terminal=`tty`


exec < $fname


count=1


while read line
do
   echo $count.$line
   	count=`expr $count + 1`  ## or let count++	
done	


exec < $terminal

