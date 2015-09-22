#OPTIND：getopts使用OPTIND作为索引，来处理下一个需要处理的参数，记录当前的状态。
#OPTARG：在上面的循环中，a，b两个参数后面各有一个冒号，冒号表示该输入的参数后面还有一个参数值，
#当getopts发现冒号后，会处理用户输入的参数值，这个参数值被保存在OPTARG中。
#OPTSTRING：也就是上例中的 :a:b:cdefg，getopts需要处理的参数。
#注意，最前面的冒号“：”用于指定getopts工作于silent mode，
#在silent模式下，当用户输入的参数不满足OPTSTRING时，不会讲illegal option这样的错误信息打印出来，使代码看起来更加专业。
#如果想要工作在verbose模式下，可以去掉最前面的冒号

#! /bin/bash
function c1() {
cmd="rhc app create -p redhat"
while getopts  :a:t:sn opt; do
     case $opt in
         a) cmd=$cmd" -a $OPTARG" ;;
         t) cmd=$cmd" -t $OPTARG" ;;
         s) cmd=$cmd" -s" ;;
         n) cmd=$cmd" -n --no-dns" ;;
         \?) echo "Invalid param" ;;
     esac
done
echo $cmd
 }
