#!/bin/bash

file_name="/tmp/counter_file"
NUM=""

check_file(){
if [ ! -f $file_name ]
then
	touch $file_name
fi
}

counter_num() {
local_file_name=$1
while read line 
do
	NUM=$(($line+1))
done<$local_file_name
}

write_latest_num() {
NUM=$1
echo $NUM >$file_name
}

match_condition_mail(){
NUM=$1
if  [ $(($NUM%5)) -eq 0  ]
then
	send_mail	
fi
}

send_mail() {
#echo '$file_name' | mail -s "num test" -r  a.sina.com lixin@staff.sina.com.cn    
:
}
#
check_file
echo $NUM
counter_num $file_name
echo $NUM
write_latest_num $NUM
echo $NUM
match_condition_mail $NUM
