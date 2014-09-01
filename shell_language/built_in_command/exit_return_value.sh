#Example 23-7 两个数中的最大者
##############################Start
#######################################
#!/bin/bash
# max.sh: 两个整数中的最大者.
E_PARAM_ERR=-198 # 如果传给函数的参数少于2 个时的返回值.
EQUAL=-199 # 如果两个整数值相等的返回值.
# 任一个传给函数的参数值溢出
#
max2 () # 返回两个整数的较大值.
{ # 注意: 参与比较的数必须小于257.
 if [ -z "$2" ]
 then
	 return $E_PARAM_ERR
 fi

 if [ "$1" -eq "$2" ]
 then
 	return $EQUAL
 else
 	if [ "$1" -gt "$2" ]
 	then
 		return $1
 	else
 		return $2
	 fi
 fi
}

max2 $1 $2 
return_val=$?

if [ "$return_val" -eq $E_PARAM_ERR ]
then
	 echo "Need to pass two parameters to the function."
elif [ "$return_val" -eq $EQUAL ]
then
 	echo "The two numbers are equal."
else
	 echo "The larger of the two numbers is $return_val."
fi


#exit 0

 # 练习 (容易):
 # ---------------
 # 把这个脚本转化成交互式的脚本,
 #+ 也就是说,让脚本可以要求调用者输入两个整数.
##############################End
