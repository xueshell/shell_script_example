#/bin/bash  
#分类：

#使用seq产生
seq_num() {
for i in `seq 1 100`;do
echo $i
done
}
#使用条件循环
if_num(){	
for((i=1;i<100;i++));do
echo $i
done
}
#使用while循环
while_num(){	
i=1
while(($i<100));do
echo $i
i=`expr $i + 1`
done
}
#i=`expr $i + 1`还可以改为i=$(($i+1))加快运算速度(看shell支持与否)
#最慢的方法
for_in_num() {	
for i in {1..100};do
echo $i
done
}

(seq_num;if_num;while_num;for_in_num)
