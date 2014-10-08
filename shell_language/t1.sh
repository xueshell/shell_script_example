#!/bin/bash
for((i=1;i<=100;i++))
do
        name[$i]=$i;
done

echo ${#name[@]}
echo ${name[99]}
