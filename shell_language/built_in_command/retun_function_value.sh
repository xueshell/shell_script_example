#!/bin/bash



err=9

func () {
	if [[ $2 == "" ]]
	then
		echo "Input the No2 number!"
		return $err
	fi
	if [[ $@ -eq  0 ]]
	then
		echo " pls input the number!"
		return $err
	fi

	value=$( echo $1+$2 | bc -l )
	echo $value
}

read -p "Input the Num1:" num1
read -p "Input the Num2:" num2

func $num1 $num2
return_val=$?
echo $return_val
