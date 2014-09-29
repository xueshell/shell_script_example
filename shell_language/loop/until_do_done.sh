#!/bin/bash


if [[  $@ -eq 0 ]] 
then
	echo " input number only "
	exit 55
fi

#until [[ "$num" =~ "^[0-9]+$" ]] #  输入的全部是数字
#			         #直到条件满足才停止;  条件不满足一直执行 
#do
#
#　　　　read -p "Please enter the number:" num
#
#done
#
#echo " The numbers you enter is $num "



#!/bin/bash
# Program:
#	Repeat question until user input correct answer.
# History:
# 2005/08/29	VBird	First release
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
 
until [ "$yn" == "yes" -o "$yn" == "YES" ]
do
	read -p "Please input yes/YES to stop this program: " yn
done
echo "OK! you input the correct answer."
