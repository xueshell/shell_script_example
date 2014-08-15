#!/bin/bash
# 我们用“&”把进程放入后台以后，如果需要了解进程的执行情况，可以使用wait函数。
#
#默认情况下wait会等待任意子进程结束但是不会返回子进程的返回值。
#
#而以子进程的pid作为参数调用wait时，wait便能够返回该子进程的退出状态了。 
function sub_shell()
{  
   var=`expr $1 \* $var`  
   echo "in var = $var"  
   return $var  
 }  



 
i=0  
var=10  

for i in `seq 10`; do  
   sub_shell $i &  
done  
 
for pid in $(jobs -p); do  
    wait $pid  
    echo "return var = $?"  
 done  
 
 echo "all done"  
