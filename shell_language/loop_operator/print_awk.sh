#!/bin/bash
ip_list="1.1.1.1,2.2.2.2,3.3.3.3,4.4.4.4,5.5.5.5"
ITERATIONS=4
for (( i=1; i<=$ITERATIONS; i++ ))
do
#       HOST=`echo $ip_list | awk -F, '{ print $i  }'` 
#       echo $HOST
#       #ping -c5 $HOST &
#echo $i
echo -------------
echo $ip_list | awk -F, '{ print $'"$i"' ;  }'
#echo $ip_list | awk -F, '{for(i=1;i<=NF;i++) print $i ;  }' 
done
#exit 0
