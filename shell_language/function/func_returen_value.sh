#!/bin/sh 

check_user()
{
	n=`cat /etc/passwd | cut -d ":" -f 1 | grep "^$1$" -Rn | cut -d ":" -f 1`
	echo $n  #这里是使用echo语句，将结果输出到标准输出上，所以在主程序中可以使用变量接收
}

userinfo()
{
	userinfo=`head -$1 /etc/passwd | tail -1 | cut -d ":" -f 3,4`
	echo $userinfo
}

while true
do
	read username
	m=`check_user $username`
	#使用变量接收函数check_user传递的值

	if [ -n "$m" ]
	then
		userinfo $m
		exit
	else
		echo "$username is not exit!"
	fi

done

