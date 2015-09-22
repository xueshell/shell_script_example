
#./test.sh -f config.conf -v --prefix=/home
#   我们称-f为选项，它需要一个参数，即config.conf, -v 也是一个选项，但它不需要参数。
# --prefix我们称之为一个长选项，即选项本身多于一个字符，它也需要一个参数，用等号连接，当然等号不是必须的，/home可以直接写在--prefix后面，即--prefix/home,更多的限制后面具体会讲到。
#   在bash中，可以用以下三种方式来处理命令行参数，每种方式都有自己的应用场景。
#
#    * 手工处理方式
#    * getopts
#    * getopt

 

#2. getopts/getopt

#处理命令行参数是一个相似而又复杂的事情，为此，C提供了getopt/getopt_long等函数，
#C++的boost提供了Options库，在shell中，处理此事的是getopts和getopt.

#getopts和getopt功能相似但又不完全相同，其中getopt是独立的可执行文件，而getopts是由Bash内置的。

#先来看看参数传递的典型用法:
#
#    * ./test.sh -a -b -c  ： 短选项，各选项不需参数
#    * ./test.sh -abc   ： 短选项，和上一种方法的效果一样，只是将所有的选项写在一起。
#    * ./test.sh -a args -b -c ：短选项，其中-a需要参数，而-b -c不需参数。
#    * ./test.sh --a-long=args --b-long ：长选项

#我们先来看getopts,它不支持长选项。

#使用getopts非常简单：
#代码
#
#复制代码

#test.sh

#!/bin/bash

while getopts "a:bc" arg #选项后面的冒号表示该选项需要参数
do
        case $arg in
             a)
                echo "a's arg:$OPTARG" #参数存在$OPTARG中
                ;;
             b)
                echo "b"
                ;;
             c)
                echo "c"
                ;;
             ?)  #当有不认识的选项的时候arg为?
            echo "unkonw argument"
        exit 1
        ;;
        esac
done

#复制代码



#现在就可以使用：
#./test.sh -a arg -b -c
#或
#./test.sh -a arg -bc
#来加载了。
#应该说绝大多数脚本使用该函数就可以了，如果需要支持长选项以及可选参数，那么就需要使用getopt.
#下面是getopt自带的一个例子：

#复制代码


#!/bin/bash

# A small example program for using the new getopt(1) program.
# This program will only work with bash(1)
# An similar program using the tcsh(1) script language can be found
# as parse.tcsh

# Example input and output (from the bash prompt):
# ./parse.bash -a par1 'another arg' --c-long 'wow!*\?' -cmore -b " very long "
# Option a
# Option c, no argument
# Option c, argument `more'
# Option b, argument ` very long '
# Remaining arguments:
# --> `par1'
# --> `another arg'
# --> `wow!*\?'

# Note that we use `"$@"' to let each command-line parameter expand to a
# separate word. The quotes around `$@' are essential!
# We need TEMP as the `eval set --' would nuke the return value of getopt.

#-o表示短选项，两个冒号表示该选项有一个可选参数，可选参数必须紧贴选项
#如-carg 而不能是-c arg
#--long表示长选项
#"$@"在上面解释过
# -n:出错时的信息
# -- ：举一个例子比较好理解：
#我们要创建一个名字为 "-f"的目录你会怎么办？
# mkdir -f #不成功，因为-f会被mkdir当作选项来解析，这时就可以使用
# mkdir -- -f 这样-f就不会被作为选项。

TEMP=`getopt -o ab:c:: --long a-long,b-long:,c-long:: \
     -n 'example.bash' -- "$@"`

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

# Note the quotes around `$TEMP': they are essential!
#set 会重新排列参数的顺序，也就是改变$1,$2...$n的值，这些值在getopt中重新排列过了
eval set -- "$TEMP"

#经过getopt的处理，下面处理具体选项。

while true ; do
        case "$1" in
                -a|--a-long) echo "Option a" ; shift ;;
                -b|--b-long) echo "Option b, argument \`$2'" ; shift 2 ;;
                -c|--c-long)
                        # c has an optional argument. As we are in quoted mode,
                        # an empty parameter will be generated if its optional
                        # argument is not found.
                        case "$2" in
                                "") echo "Option c, no argument"; shift 2 ;;
                                *)  echo "Option c, argument \`$2'" ; shift 2 ;;
                        esac ;;
                --) shift ; break ;;
                *) echo "Internal error!" ; exit 1 ;;
        esac
done
echo "Remaining arguments:"
for arg do
   echo '--> '"\`$arg'" ;
done

#复制代码



#比如我们使用
#./test -a  -b arg arg1 -c
#你可以看到,命令行中多了个arg1参数，在经过getopt和set之后，命令行会变为：
#-a -b arg -c -- arg1
#$1指向-a,$2指向-b,$3指向arg,$4指向-c,$5指向--,而多出的arg1则被放到了最后。

#3.总结
#一般小脚本手工处理也许就够了，getopts能处理绝大多数的情况，getopt较复杂，功能也更强大。
#有问题请指出，不胜感激。
#
