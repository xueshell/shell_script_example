
# git_rsync_to_host.sh: rsync 推送代码到主机 
#
# Copyright (C) 2015
#
#
#
# Author(s): lixin@staff.sina.com.cn
#
#
# --iterations  处理的任务总数
# --workers     同时并行的最大任务总数
#
#
#

echo $*
#rsync_user="$1"
#rsync_module="$2"
#ip_list="$3"
#src_path="$4"

ip_list="10.210.71.140,10.55.37.64,10.210.132.20,1.1.1.1"

echo +++++++++
ITERATIONS=$( echo $ip_list | awk -F, '{ print NF }')
echo -----
echo 总数 $ITERATIONS
echo -----


for (( i=1; i<=$ITERATIONS; i++ ))
do
#       HOST=`echo $ip_list | awk -F, '{ print $i  }'` 
#       echo $HOST
#        echo $i 
        HOST=` echo $ip_list | awk -F, '{ print $"'$i'" }' `
    #   cd "$4"
    #    echo rsync -av  * $rsync_user@$HOST::$rsync_module
    #    rsync -av  * $rsync_user@$HOST::$rsync_module
	echo ping $HOST
       ping -c20  $HOST >/dev/null &&   echo $?>/tmp/err  & 

#        if [ $? -ne 0 ]
#        then
#                echo "推送 $HOST 失败 !! "
#        else
#                echo "推送 $HOST 成功!!"
#        fi
done
#echo $ip_list | awk -F, '{for(i=1;i<=NF;i++) print $i ;  }' 

#检查后台任务的返回状态
#for pid in $(jobs -p); do  
#    echo pid : $pid 
#    wait $pid && echo "return var = $?"  &
# done  

#exit 0
##ITERATIONS=50
#WORKERS=5

#USAGE="$0 [--iterations num] [--workers num] COMMAND"

#while [ $# -gt 0 ]; do
#    case "$1" in
#    (--iterations) ITERATIONS=$2; shift;;
#    (--workers) WORKERS=$2; shift;;
#    (--help) echo $USAGE; exit 0;;
#    (--) shift; break;;
#    (*)  break;;
#    esac
#    shift
#done

#WORKER_COMMAND=${@-"sleep 2"} #如果没有参数输入，默认返回"sleep 2"
#WORKER_COMMAND=" ping -c5 www.gitant.com "
#WORKER_COMMAND=" ping -c5 www.gitant.com "

#MAX_WORKERS_FILE=$(mktemp -t parallel.workers.XXXXX) || exit 1
#echo $WORKERS > $MAX_WORKERS_FILE #最大并行的处理个数
#
#echo "Starting $ITERATIONS iterations of '$WORKER_COMMAND' with $WORKERS parallel workers."
#echo "Workers can be altered at runtime by editing $MAX_WORKERS_FILE"
#echo "Press any key to continue..."
#read -n 1 c
#
#for ((i=1; i<=$ITERATIONS; i++)); do
#    while (true); do
#        MAX_WORKERS=$(cat $MAX_WORKERS_FILE)
#        WORKERS=$(jobs -r | wc -l) #检查并行运行的任务总数
#        echo -e "Workers: $WORKERS / $MAX_WORKERS"
#        [[ $WORKERS -lt $MAX_WORKERS ]] && break || sleep 1
#    done
#    echo "$i: $WORKER_COMMAND"
#    eval "$WORKER_COMMAND &"
#done
#
#unlink $MAX_WORKERS_FILE
#echo -e "Completed $((i-1)) iterations of '$WORKER_COMMAND'"
#exit 0
