#!/bin/bash


filename=$1
count=0


while read LINE
do
	let count++
	echo "$count  $LINE"
done < $filename


echo  "\nTotal $count line read"

