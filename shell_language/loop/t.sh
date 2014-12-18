#!/bin/bash
arr=( h0 h1 h2 h3 )
t=""
for i in ${!arr[@]}
do
t="$t","${arr[$i]}"
echo ${arr[$i]}
done

#echo ${arr[@]:0}
echo $t
echo ${!arr[@]}
