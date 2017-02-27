#!/bin/bash
#pangge
STATUS="true"
LOG_FILE="/tmp/dialup_log"
CMLI="nmcli con up uuid uuid"
DT=$(date "+%Y-%m-%d %H:%M:%S")

#循环检查状态
while $STSTUS

do
    
    $(nmcli con status) | grep uuid  #检查连接
    if [ $? -ne 0 ]  #没有连接
    then
        echo "$DT Disconnected, trying to reconnect…" >>$LOG_FILE #没有连接
        eval $CMLI #发起拨号 

        if [ $? -ne 0 ]  #是否拨号成功
        then
            echo "无法拨号！检查系统！"| mail 810706570@qq.com 
            exit 0 #退出系统
        fi
        # nmcli con up uuid uuid
        # echo "$DT Already connected !" >>$LOG_FILE
    fi
    
    sleep 1m
    
done
