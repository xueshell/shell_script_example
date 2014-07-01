#!/bin/bash
v1=aaa
v2=bbb
c=1
if [ $c -eq 1 ]
then
vname=v$c #找到符合条件的变量名为v1
#eval vvv="$"$vname ; echo vvv: $vvv #将变量v1的值赋予vvv,即,使vvv=aaa
eval vvv='$'$vname ; echo vvv: $vvv #将变量v1的值赋予vvv,即,使vvv=aaa
#eval vvv=$$vname ; echo vvv: $vvv #错误用法
#vvv=$"$vname" ; echo vvv: $vvv #错误用法
fi

