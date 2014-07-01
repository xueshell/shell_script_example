#寻找符合条件的变量名,然后将该变量的值赋予另一变量
#v1=aaa
#v2=bbb
#c=1
#if [ $c -eq 1 ]
#then
#vname=v$c #找到符合条件的变量名为v1
#eval vvv="$"$vname ; echo vvv: $vvv #将变量v1的值赋予vvv,即,使vvv=aaa
#eval vvv='$'$vname ; echo vvv: $vvv #将变量v1的值赋予vvv,即,使vvv=aaa
##eval vvv=$$vname ; echo vvv: $vvv #错误用法
#fi

#例二:

#以变量v1的值aaa作为变量名,将变量vaaa的值赋予这一新定义的变量aaa
v1=aaa ; vaaa="This is aaa"
#eval $v1=$vaaa ; echo aaa: $aaa #错误用法
#eval $v1="$vaaa" ; echo aaa: $aaa #错误用法
eval $v1='$vaaa' ; echo aaa: $aaa

#例三:


#以变量v1的值aaa作为变量名,并将变量名字串作为值赋予自身
v1=aaa ; vaaa="This is aaa"
eval $v1=$v1 ; echo aaa: $aaa #与例二的错误用法不同,这一用法是正确的
eval $v1="$v1" ; echo aaa: $aaa #与例二的错误用法不同,这一用法是正确的
#区别在于，例二中的vaaa的值中间有空格
eval $v1='$v1' ; echo aaa: $aaa




#------------------------------------------------------------------------------------------

#eval eval eval echo \\\\\$\\\$\$$Value
