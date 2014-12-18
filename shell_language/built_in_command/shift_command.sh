#!/bin/bash  
#shift 上档命令的应用(shft2.sh)  
if [ $# -eq 0 ]  
then  
	echo "Usage:shift2.sh 参数"  
	exit 1  
fi  
sum=0  
until [ $# -eq 0 ]  
do  
    sum=`expr $sum + $1`  
    shift  
done  

echo "sum is: $sum"  
