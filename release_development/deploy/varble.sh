#!/bin/bash
var1="1.1.1.1
	2.2.2.2
	3.3.3.3
	4.4.4.4"
var2="5.5.5.5
	6.6.6.6
	7.7.7.7
	8.8.8.8"

str1="${var1} ${var2}"
echo $str1

m=${str1:5:15}
echo $m
