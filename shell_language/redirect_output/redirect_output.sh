#!/bin/bash

rd_out_2f()
{
    echo "Hello kate, this is error." >&2                   #定向到文件描述符的时候，描述符前加 &
    echo "This is a goog dog!" >testout_file           #重定向到文件
}


rd_out_fd()
{
    exec 3>&1                      #新建输出描述符
    exec 1>testout

    echo "This should store in the output file"
    echo "along with this line." >&3

    exec 1>&3                      #将描述符1输入重定向到标准输入
    exec 3>&-                       #关闭描述符3   关闭其实就是定向到一个特殊的描述符 -
    echo "Now things should be back normal."
}

rd_in_fd()
{
    echo -e "\t### redirect input ###"
    exec 6<&0 　　　　　＃新建描述符，暂存标准输入描述符
    exec 0<inputfile             #重定向标准输入

    count=1
    while read line
    do
        echo "Line #$count:$line"
        count=$[ $count + 1 ]
    done

    exec 0<&6　　　　　＃将０重新定向到标准输入
    exec 6<&-　　　　　＃关闭描述符

    read -p "Are you done now?"
    case $REPLY in
        Y|y) echo "Goodbye!"
            ;;
        N|n) echo "Sorry this is end!"
            ;;
    esac

}



#rd_out_2f
#rd_out_fd
rd_in_fd
