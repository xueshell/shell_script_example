#!/bin/bash

FD=$(pwd)
CON=$FD/CON
CON_T=$FD/CON_T
LINE=0

if [ -d /data0/MN ] 
then
	ls /data0/MN
	echo "find mn;exit 1"
	rm -fr /data0/MN
	exit 1
fi
mkdir -p /data0/MN ; cd /data0/MN
if [ ! -e $CON ] || [ ! -e $CON_T ] 
then
	echo $LINE>$CON
	echo $LINE>$CON_T
fi

function counter(){
while read LINE 
do
	echo -n " $LINE   "
	LINE=$(($LINE+1))
	echo $LINE >$CON_T
done<$CON
mv $CON_T $CON
}

insert_value(){
id=$1
name=$2
address=$3
phone=$4
birthday=$5
mysql -uroot  -p"021120" <<EOF
   use test;
   insert into user(user_id,user_name,address,phone,birthday)values('$id','$name','$address','$phone','$birthday');
EOF
}
for M in {a..z}
do
	for N in {A..Z}
	do
		for X in {a..z}
		do
			for Z in {A..Z}
			do	
			echo -n " $M$N$X$Z  "
			echo  " "
		#	mkdir $M$N$X$Z
			insert_value $M $N $X $Z 19900101 
			counter
			done
		done
	
	done
done
#ls /data0/MN | wc -l

