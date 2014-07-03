for((i=1;i<=10;i++))
do
#echo ++++++
#echo $i
echo ------
echo $(expr $i \* 4)
done
#在shell中常用的是 for i in $(seq 10)
#for i in `ls`

#for i in ${arr[@]}
#for i in $* ; do
#for File in /proc/sys/net/ipv4/confaccept_redirects：'
#for File in /proc/sys/net/ipv4/conf/*/accept_redirects; do
#echo $File
#done
#echo "直接指定循环内容"
#for i in f1 f2 f3 ;do
#echo $i
#done
#echo
#echo "C 语法for 循环:"
#for (( i=0; i<10; i++)); do
#echo $i
#done
