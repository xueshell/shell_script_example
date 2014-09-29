#!/bin/bash


read -p   "Input the value:" line
echo $line

if [[ $line > 100 ]]
then
	echo $line
else
	echo  error
fi
