   
#!/bin/bash   
# 测试字符串范围.   
  
echo; echo "Hit a key, then hit return."   
read Keypress  
  
case  "$Keypress"  in   
  [[:lower:]]   ) echo "Lowercase letter" ;;  
  [[:upper:]]   ) echo "Uppercase letter" ;;  
  [0-9]         ) echo "Digit" ;;  
  *             ) echo "Punctuation, whitespace, or other" ;;  
esac 
#  允许字符串的范围出现在[中括号]中,   
#+ 或者出现在POSIX风格的[[双中括号中.   
  
#  在这个例子的第一个版本中,   
#+ 测试大写和小写字符串的工作使用的是   
#+ [a-z] 和 [A-Z].   
#  这种用法在某些特定场合的或某些Linux发行版中不能够正常工作.   
#  POSIX 的风格更具可移植性.   
#  感谢Frank Wang指出了这点.   
  
#  练习:   
#  -----   
#  就像这个脚本所表现出来的, 它只允许单次的按键, 然后就结束了.   
#  修改这个脚本, 让它能够接受重复输入,   
#+ 报告每次按键, 并且只有在"X"被键入时才结束.   
#  暗示: 将这些代码都用"while"循环圈起来.   
  
exit 0  

function comment() {
#    例子 10-25. 使用case来创建菜单 


#!/bin/bash   
  
# 未经处理的地址资料   
  
clear # 清屏.   
  
echo "          Contact List"   
echo "          ------- ----"   
echo "Choose one of the following persons:"   
echo  
echo "[E]vans, Roland"   
echo "[J]ones, Mildred"   
echo "[S]mith, Julie"   
echo "[Z]ane, Morris"   
echo  
  
read person  
  
case  "$person"  in   
# 注意, 变量是被""引用的.   
  
  "E"  | "e"  )  
  # 接受大写或者小写输入.   
  echo  
  echo "Roland Evans"   
  echo "4321 Floppy Dr."   
  echo "Hardscrabble, CO 80753"   
  echo "(303) 734-9874"   
  echo "(303) 734-9892 fax"   
  echo "revans@zzy.net"   
  echo "Business partner & old friend"   
  ;;  
# 注意, 每个选项后边都要以双分号;;结尾.   
  
  "J"  | "j"  )  
  echo  
  echo "Mildred Jones"   
  echo "249 E. 7th St., Apt. 19"   
  echo "New York, NY 10009"   
  echo "(212) 533-2814"   
  echo "(212) 533-9972 fax"   
  echo "milliej@loisaida.com"   
  echo "Ex-girlfriend"   
  echo "Birthday: Feb. 11"   
  ;;  
  
# 后边的 Smith 和 Zane 的信息在这里就省略了.   
  
          * )  
   # 默认选项.   
   # 空输入(敲回车RETURN), 也适用于这里.   
   echo  
   echo "Not yet in database."   
  ;;  
  
esac  
  
echo  
  
#  练习:   
#  -----   
#  修改这个脚本, 让它能够接受多个输入,   
#+ 并且能够显示多个地址.   
  
exit 0  


    一个case的非常聪明的用法, 用来测试命令行参数. 


#! /bin/bash   
  
case  "$1"  in   
"" ) echo "Usage: ${0##*/} <filename>" ; exit $E_PARAM ;;  # 没有命令行参数,  
                                                        # 或者第一个参数为空.   
# 注意: ${0##*/} 是 ${var##pattern} 的一种替换形式. 得到的结果为$0.   
  
-*) FILENAME=./$1 ;;   #  如果传递进来的文件名参数($1)以一个破折号开头,   
                      #+ 那么用./$1来代替.   
                      #+ 这样后边的命令将不会把它作为一个选项来解释.   
  
* ) FILENAME=$1 ;;     # 否则, $1.   
esac  


    这是一个命令行参数处理的更容易理解的例子: 


#! /bin/bash   
  
  
while  [ $# -gt 0 ]; do    # 直到你用完所有的参数 . . .   
  case  "$1"  in   
    -d|--debug)  
              # 是 "-d" 或 "--debug" 参数?   
              DEBUG=1  
              ;;  
    -c|--conf)  
              CONFFILE="$2"   
              shift  
              if  [ ! -f $CONFFILE  ]; then   
                echo "Error: Supplied file doesn't exist!"   
                exit $E_CONFFILE      # 错误: 文件未发现.   
              fi  
              ;;  
  esac  
  shift       # 检查剩余的参数.   
done  
  
#  来自Stefano Falsetto的 "Log2Rot" 脚本,   
#+ 并且是他的"rottlog"包的一部分.   
#  已得到使用许可.   


    例子 10-26. 使用命令替换来产生case变量 


#!/bin/bash   
# case-cmd.sh: 使用命令替换来产生"case"变量.   
  
case  $( arch ) in    # "arch" 返回机器体系的类型.   
                    # 等价于 'uname -m' ...   
i386 ) echo "80386-based machine" ;;  
i486 ) echo "80486-based machine" ;;  
i586 ) echo "Pentium-based machine" ;;  
i686 ) echo "Pentium2+-based machine" ;;  
*    ) echo "Other type of machine" ;;  
esac  
  
exit 0  


    case结构也可以过滤通配(globbing)模式的字符串. 

    例子 10-27. 简单的字符串匹配 


#!/bin/bash   
# match-string.sh: 简单的字符串匹配   
  
match_string ()  
{  
  MATCH=0  
  NOMATCH=90  
  PARAMS=2     # 此函数需要2个参数.   
  BAD_PARAMS=91  
  
  [ $# -eq $PARAMS ] || return $BAD_PARAMS   
  
  case  "$1"  in   
  "$2" ) return  $MATCH ;;  
  *   ) return  $NOMATCH ;;  
  esac  
  
}    
  
  
a=one  
b=two  
c=three  
d=two  
  
  
match_string $a      # 参数个数错误.   
echo $?             # 91   
  
match_string $a  $b   # 不匹配   
echo $?             # 90   
  
match_string $b  $d   # 匹配   
echo $?             # 0   
  
  
exit 0    
                  

    例子 10-28. 检查输入字符是否为字母 


#!/bin/bash   
# isalpha.sh: 使用"case"结构来过滤字符串.   
  
SUCCESS=0  
FAILURE=-1  
  
isalpha ()  # 检查输入的 *第一个字符* 是不是字母表上的字符.   
{  
if  [ -z "$1"  ]                # 没有参数传进来?   
then   
  return  $FAILURE   
fi  
  
case  "$1"  in   
[a-zA-Z]*) return  $SUCCESS ;;  # 以一个字母开头?   
*        ) return  $FAILURE ;;  
esac  
}             # 同C语言的"isalpha ()"函数比较一下.   
  
  
isalpha2 ()   # 测试 *整个字符串* 是否都是字母表上的字符.   
{  
  [ $# -eq 1 ] || return $FAILURE   
  
  case  $1  in   
  *[!a-zA-Z]*|"" ) return  $FAILURE ;;  
               *) return  $SUCCESS ;;  
  esac  
}  
  
isdigit ()    # 测试 *整个字符串* 是否都是数字.   
{             # 换句话说, 就是测试一下是否是整数变量.   
  [ $# -eq 1 ] || return $FAILURE   
  
  case  $1  in   
  *[!0-9]*|"" ) return  $FAILURE ;;  
            *) return  $SUCCESS ;;  
  esac  
}  
  
  
  
check_var ()  # 测试isalpha().   
{  
if  isalpha "$@"   
then   
  echo "/"$*/" begins with an alpha character."   
  if  isalpha2 "$@"   
  then         # 不需要测试第一个字符是否是non-alpha.   
    echo "/"$*/" contains only alpha characters."   
  else   
    echo "/"$*/" contains at least one non-alpha character."   
  fi    
else   
  echo "/"$*/" begins with a non-alpha character."   
              # 如果没有参数传递进来, 也是"non-alpha".   
fi  
  
echo  
  
}  
  
digit_check ()  # 测试isdigit().   
{  
if  isdigit "$@"   
then   
  echo "/"$*/" contains only digits [0 - 9]."   
else   
  echo "/"$*/" has at least one non-digit character."   
fi  
  
echo  
  
}  
  
a=23skidoo  
b=H3llo  
c=-What?  
d=What?  
e=`echo $b `   # 命令替换.   
f=AbcDef  
g=27234  
h=27a34  
i=27.34  
  
check_var $a   
check_var $b   
check_var $c   
check_var $d   
check_var $e   
check_var $f   
check_var     # 没有参数传递进来, 将会发生什么?   
#   
digit_check $g   
digit_check $h   
digit_check $i   
  
  
exit 0        # S.C改进了这个脚本.   

    
     # 练习: 
     # ----- 
     #  编写一个'isfloat ()'函数来测试浮点数. 
     #  暗示: 这个函数基本上与'isdigit ()'相同, 
     #+ 但是要添加一些小数点部分的处理. 

select 

    select结构是建立菜单的另一种工具, 这种结构是从ksh中引入的. 

    select variable [in list] 
    do 
     command... 
    燽reak 
    done 

    提示用户输入选择的内容(比如放在变量列表中). 注意: select命令使用PS3提示符, 默认为(#?), 当然, 这可以修改. 

    例子 10-29. 使用select来创建菜单 


#!/bin/bash   
  
PS3='Choose your favorite vegetable: '  # 设置提示符字串.   
  
echo  
  
select vegetable in  "beans"  "carrots"  "potatoes"  "onions"  "rutabagas"   
do   
  echo  
  echo "Your favorite veggie is $vegetable."   
  echo "Yuck!"   
  echo  
  break   # 如果这里没有 'break' 会发生什么?   
done  
  
exit 0  


    如果忽略了in list列表, 那么select命令将会使用传递到脚本的命令行参数($@), 或者是函数参数(当select是在函数中时). 

    与忽略in list的 

    for variable [in list] 
    结构比较一下. 

    例子 10-30. 使用函数中的select结构来创建菜单 

#!/bin/bash   
  
PS3='Choose your favorite vegetable: '   
  
echo  
  
choice_of()  
{  
select vegetable  
# [in list]被忽略, 所以'select'使用传递给函数的参数.   
do   
  echo  
  echo "Your favorite veggie is $vegetable."   
  echo "Yuck!"   
  echo  
  break   
done  
}  
  
choice_of beans rice carrots radishes tomatoes spinach  
#         $1    $2   $3      $4       $5       $6   
#         传递给choice_of()的参数   
  
exit 0 

}
