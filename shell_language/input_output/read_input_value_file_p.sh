 #!/bin/bash
# shell 读取变量值
#用系统变量REPLY保存输入的值
#REPLY 
#REPLY变量与read和select命令有关
#read命令用于读取标准输入（stdin）的变量值
#    read variable                  #varibale是变量名
#read将读到的标准输入存储到variable变量中。read命令也可以不带任何变量名，此时，read就将读到的标准输入存储到REPLY变量中
#REPLY
 
read_2reply()
{
    read -p "Enter a number:"
    for (( count=1; count<=$REPLY; count++ ))
    do
        count=$[ $count +1 ]
    done
    echo "The count of your number is $count"

}


#读取多个值
read_2p()
{
    read -p "Enter your name:" first last
    echo "Your English format name is:$last $first"
}


#设置读取时间和读取的字符数
read_tn()
{
    if read -t 5 -n 1 -p "Do you want to continue [Y/N]:"
    then
        case $REPLY in
            Y|y)
                echo -e "\ncontinue on ...\n\n\n"

                read -s -p "Please input your password:" pass
                if [ $pass == "123456" ]
                then
                    echo -e "\nYou are pass is ok!\n"
                else
                    echo -e "\nYou are bad boy with wrong pass!\n"
                fi

                ;;
            N|n)
                echo -e "\nOK,goodbye\n"
                exit
                ;;
        esac
    else
            echo -e "You are too slow!\n"
    fi
}


#读取文件
read_file()
{
    echo "hello"
    if read -t 10 -p "Please input file name you want to see:" file_name
    then
        if [ -n "$file_name" ]
        then
            count=1
            cat $file_name |while read line
            do
                echo "Line $count:$line"
                count=$[ $count +1  ]
            done
        fi
    else
        echo -e "\nSorry you are too slow, input time is over!"
    fi
}


#测试
#function test
read_2reply
#read_2p yang
#read_tn
