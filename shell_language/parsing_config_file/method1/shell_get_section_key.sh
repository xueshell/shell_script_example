#!/bin/bash
#tackoverflow的例子，改了一个出来：
#复制代码 代码如下:

while IFS='= ' read var val
do
    if [[ $var == \[*] ]]
    then
       echo section=$(echo $var | sed 's/^\[\(.*\)\]$/\1/')
    #   section=$(echo $var | sed 's/^\[\(.*\)\]$/\1/p')
    elif [[ $val ]]
    then
        if [ -z $section ];then
            declare "${var}=$val"
        else
            declare "${section}.${var}=$val"
        fi  
    fi  
done < config.ini

#echo "Serial Number...............123456789" |sed 's/Serial Number.*\([0-9]\{9\}\)/\1/'


#使用的时候：


#复制代码 代码如下:
#${section.key}


#就可以读到变量啦。

#二、复杂版

#
#复制代码 代码如下:
#[comon]
#ids=com1,com2,com3
#files=profilefile
# 
 
#[com1]
#key="name"
#file="test"
# 
#[com2]
#key="name1"
#file="test"
# 
#[com3]
#key="name2"
#file="test"
#
#
#取[com1]的key值我查了下，还好在ChinaUnix里面查到了命令(貌似一位叫wintty兄写的)：
#
#
#复制代码 代码如下:awk -F '=' '/\[com1\]/{a=1}a==1&&$1~/key/{print $2;exit}' config.ini
#这样就简单取到值了。
#查了下命令终于明白，命令分为两个部分：
#先模式匹配到：[com1]然后执行动作：a=1，再接着有来个模式+命令
#模式：“a==1&&$1~/key/”
#a==1因为已经赋值了，所以执行下一步，如果$1第一个字段匹配key的值，则
#打印第2项，紧接着退出，退出就不会打印到匹配[com2]和[com3]的key值.
# 
#需求会变得，现在变成取【com】几个key对应的值，提供的shell的脚本如下：
#复制代码 代码如下:
##！/bin/sh
#getconfig()
#{
#  SECTION=$1
#  CONFILE=$2
#  ENDPRINT="key\tfile\t"
#  echo "$ENDPRINT"
#  for loop in `echo $ENDPRINT|tr '\t' ' '`
#  do
#       #这里面的的SECTION的变量需要先用双引号，再用单引号，我想可以这样理解，
#       #单引号标示是awk里面的常量，因为$为正则表达式的特殊字符，双引号，标示取变量的值
#       #{gsub(/[[:blank:]]*/,"",$2)去除值两边的空格内容
#       awk -F '=' '/\['"$SECTION"'\]/{a=1}a==1&&$1~/'"$loop"'/{gsub(/[[:blank:]]*/,"",$2);printf("%s\t",$2) ;exit}' $CONFILE
#  done
#}
# 
##更改变量名称
#CONFIGFILE=$1
#echo "========================================================"
##文件名称
#echo "+++ConfigName:$CONFIGFILE+++++++++++++++++++++++++++++++"
##取得ids中的每个id把，号分隔改成空格，因为循环内容要以空格分隔开来
#profile=`sed -n '/ids/'p $CONFIGFILE | awk -F= '{print $2}' | sed 's/,/ /g'`
##对于一个配置文件中的所有id循环
#for OneCom in $profile
#do
#  echo "--------------------------------------------------"
#  echo "COM:$OneCom"
  #此处函数调用有时候不能用反引号，不然会出错，此处原由还不清楚知道的麻烦请告之
#  getconfig  $OneCom  $CONFIGFILE
#  echo "\n"
#  echo "--------------------------------------------------"
#  #break
#done
#echo "========================================================"
#
# 
#执行的结果如下：
#复制代码 代码如下:$ one.sh File
#========================================================
#+++ConfigName:File+++++++++++++++++++++++++++++++
#--------------------------------------------------
#COM:com1
#key     file   
#name    file1  
#--------------------------------------------------
#--------------------------------------------------
#COM:com2
#key     file   
#name1   file2  
#--------------------------------------------------
#--------------------------------------------------
#COM:com3
#key     file   
#name2   file3  
#--------------------------------------------------
#
# 
#嘿嘿需求又变了，配置文件有多个，怎么取多个文件的配置项嘛：
#复制代码 代码如下:#！/bin/sh
#getconfig()
#{
#  SECTION=$1
#  CONFILE=$2
#  ENDPRINT="key\tfile\t"
# 
#  echo "$ENDPRINT"
#  for loop in `echo $ENDPRINT|tr '\t' ' '`
#  do
#   
#       awk -F '=' '/\['"$SECTION"'\]/{a=1}a==1&&$1~/'"$loop"'/{gsub(/[[:blank:]]*/,"",$2);printf("%s\t",$2) ;exit}' $CONFILE
#  done
#}
# 
##显示的多个文件名将多行的回车符转成逗号分隔符
#CONFIGFILES=`ls $1|tr '\n' ','`
##查看到底有多个配置文件
#_Num=`echo $CONFIGFILES|tr -cd \,|wc -c`
##临时变量保存配置多个文件
#_TMPFILES=$CONFIGFILES
#while [ $_Num -ge 1 ]
#do
#  #得到一个文件
#  CONFIGFILE=`echo $_TMPFILES|cut -d ',' -f1`
#  #余下的文件
#  _TMPFILES=`echo $_TMPFILES|cut -d ',' -f2-`
#  #配置文件数量减一
#  _Num=$(($_Num-1))
#  echo "========================================================"
#  #文件名称
#  echo "+++ConfigName:$CONFIGFILE+++++++++++++++++++++++++++++++"
#  profile=`sed -n '/ids/'p $CONFIGFILE | awk -F= '{print $2}' | sed 's/,/ /g'`
#  #对于一个配置文件中的所有id循环
#  for OneCom in $profile
#  do
#    echo "--------------------------------------------------"       
#    echo "COM:$OneCom"
#    getconfig  $OneCom  $CONFIGFILE
#    echo "\n"
#    echo "--------------------------------------------------"
#    #break
#  done
#echo "========================================================"
#done
#
# 
####
