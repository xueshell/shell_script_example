#监控机器列表文件：
#server.list
#
#server1
#server2
#server3

 
#
#建立监控脚本： webstatus.sh

 

#!/bin/sh
monitor_dir=/home/admin/monitor/
if [ ! -d $monitor_dir ]; then
    mkdir $monitor_dir
fi
cd $monitor_dir
web_stat_log=web.status
if [ ! -f $web_stat_log ]; then
   touch $web_stat_log
fi
server_list_file=server.list
if [ ! -f $server_list_file ]; then
   echo "`date '+%Y-%m-%d %H:%M:%S'` ERROR:$server_list_file NOT exists!" >>$web_stat_log
exit 1
fi
#total=`wc -l $server_list_file|awk '{print $1}'`
for website in `cat $server_list_file`
do
   url="http://$website/app.htm"
   server_status_code=`curl -o /dev/null -s -m 10 --connect-timeout 10 -w %{http_code} "$url"`
   if [ "$server_status_code" = "200" ]; then 
        echo "`date '+%Y-%m-%d %H:%M:%S'` visit $website status code 200 OK" >>$web_stat_log
   else 
        echo "`date '+%Y-%m-%d %H:%M:%S'` visit $website error!!! server can't connect at 10s or stop response at 10 s, send alerm sms ..." >>$web_stat_log
        echo "!app alarm @136xxxxxxxx  server:$website can't connect at 10s or stop response at 10s ..." | nc smsserver port &
   fi
done
exit 0

 

#主要是利用 curl -o /dev/null -s -m 10 --connect-timeout 10 -w %{http_code} "$url" 返回状态码是否200,如果10s没有返回200状态码，则发警报

#最后让linux 定时执行脚本：

#crontab -e

#*/10 * * * * /home/admin/app/bin/webstatus.sh

#这样每隔10分钟就会执行一次
#这个是另外一种脚本写法：

#!/bin/bash

while read URL
  do
    echo `date`
    result=`curl -o /dev/null -s -m 10 --connect-timeout 10 -w %{http_code}  $URL`
    test=`echo $result`
    if [[  "$test" = "200"  ]]
      then
        echo "$URL is ok"
    else
      echo "test err"
/usr/sbin/sendmail -t << EOF
From:SD-Detect
To:13918888888@139.com,13800000000@139.com
Subject:Detected $URL
------------------------------
${URL} is err!!
------------------------------
EOF
    fi
  done < /root/jiankong/httplist.txt

