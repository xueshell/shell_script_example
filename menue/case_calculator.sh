#!/bin/bash  
# 计算器，用case实现  
echo " Calculator"  
echo "1.+"  
echo "2.-"  
echo "3.*"  
echo "4./"  
  
echo -n "Enter your choice :"  
read I  
  
case $I in  
  1)  
    echo "Enter the first number:"  
    read A  
    echo "Enter the second number:"  
    read B  
    echo "the result is:"  
    echo " $A + $B " | bc  
  ;;  
  2)  
    echo "Enter the second number:"  
    read A  
    echo "Enter the second number:"  
    read B  
    echo "the result is:"  
    echo " $A - $B " | bc  
  ;;  
  3)  
    echo "Enter the first number:"  
    read A  
    echo "Enter the second number:"  
    read B  
    echo "the result is:"  
    echo " $A * $B " | bc  
  ;;  
  4)  
    echo "Enter the first number:"  
    read A  
    echo "Enter the second number:"  
    read B  
    echo "the result is:"  
    echo " $A / $B " | bc  
  ;;  
  *)  
    echo "`basename $0`: a simple calculator"  
  ;;  
esac 
