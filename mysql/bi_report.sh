#!/bin/bash

GIGA=1000000000

content="\n"
prefix='bi'
today=`date -d"-1 day" +%Y-%m-%d`
yestoday=`date -d"-2 day" +%Y-%m-%d`
lastweek=`date -d"-8 day" +%Y-%m-%d`
lastmonth=`date -d"-1 month -1 day" +%Y-%m-%d`

#此处需要做重试，否则，当有数据被删除的时候，统计失败
hadoop fs -du /user/hive/warehouse/bi.db/ &nbsp;> ./tmp.bi.db.stat
while [ $? -ne 0 ]
do
&nbsp; &nbsp; &nbsp; &nbsp; hadoop fs -du /user/hive/warehouse/bi.db/ &nbsp;> ./tmp.bi.db.stat
done
#dpstg开头的表不做统计
grep -v dpstg ./tmp.bi.db.stat > bi.db.stat&nbsp;

awk '{if(NR!=1) {size=split($2,table_list,"/"); print table_list[size],"\t",$1}}' ./bi.db.stat > $prefix.$today

sum=`awk '{sum+=$2} END{printf("%d",sum/"'$GIGA'")}' $prefix.$today`
content+="总大小:"$sum"G\n"

yes_sum=`awk '{sum+=$2} END{print sum/"'$GIGA'"}' $prefix.$yestoday`
diff_size=`echo "$sum-$yes_sum" | bc`
content+="日同比新增数据量:"$diff_size"G\n"

week_sum=`awk '{sum+=$2} END{print sum/"'$GIGA'"}' $prefix.$lastweek`
diff_size=`echo "$sum-$week_sum" | bc`
content+="周同比新增数据量:"$diff_size"G\n"

month_sum=`awk '{sum+=$2} END{print sum/"'$GIGA'"}' $prefix.$lastmonth`
diff_size=`echo "$sum-$month_sum" | bc`
content+="月同比新增数据量:"$diff_size"G\n"

table_count=`wc -l $prefix.$today | awk '{print $1}'` 
content+="\n\n总表数:"$table_count"\n"

yes_table_count=`wc -l $prefix.$yestoday | awk '{print $1}'` 
diff_table_count=`echo "$table_count-$yes_table_count" | bc`
content+="日新增表数:"$diff_table_count"\n"

lastweek_table_count=`wc -l $prefix.$lastweek | awk '{print $1}'` 
diff_table_count=`echo "$table_count-$lastweek_table_count" | bc`
content+="周新增表数:"$diff_table_count"\n"

lastmonth_table_count=`wc -l $prefix.$lastmonth | awk '{print $1}'` 
diff_table_count=`echo "$table_count-$lastmonth_table_count" | bc`
content+="月新增表数:"$diff_table_count"\n"


max_table="`sort -r -n -k 2 $prefix.$today | head -20 | awk '{ORS="";print $1"：" $2/"'$GIGA'""G\\\\n"}'`"
content+="\n\n最大的20张表:\n"$max_table"\n"

declare -A ARR1
while read line
do
	key=`echo $line|awk '{print $1}'`
	value=`echo $line|awk '{print $2}'`
	ARR1["$key"]=$value
done < $prefix.$today
declare -A ARR2
while read line
do
	key=`echo $line|awk '{print $1}'`
	value=`echo $line|awk '{print $2}'`
	ARR2["$key"]=$value
done < $prefix.$yestoday
for k in "${!ARR1[@]}"
do
	d_val=`echo "${ARR1[${k}]}-${ARR2[${k}]}"|bc` 
	ARR1["$k"]=$d_val
done
cat /dev/null > bi_tmp.txt
for k in "${!ARR1[@]}"
do
    echo "$k ${ARR1[${k}]}" >> bi_tmp.txt
done
max_incre_table="`sort -r -n -k 2 bi_tmp.txt | head -20 | awk '{ORS="";print $1"：" $2/"'$GIGA'""G\\\\n"}'`"
content+="\n\n表数据增量TOP20:\n"$max_incre_table"\n"

#echo -e $content

msg=`echo $content`

python mail.py "HIVE BI每日统计" $msg