#!/bin/bash

smail() {
mail -s "$1" apparitor@gmail.com <<EOF
$1
$2
====
report time: `date +"%F %T"`
current user: `whoami`
shell script: `echo $0`
====
EOF
}

ssms() {
/usr/local/feixin/fetion --mobile=150000000 --pwd=******** --to=13810000000 --msg-gb="fx $1"
}

cd /home/maintain/gaojianwei/Script/
File=Monitor_IP.txt
sed -i /.*/d Curl_Out.txt
sed -i /.*/d Curl_Out_1.txt

sed -e '/^#/d;/^$/d' ${File} | while read Ip Port URL
do
/usr/bin/curl --connect-timeout 8 --max-time 12 -o /dev/null -s -w %{time_total}:%{size_download}:%{http_code} http://${URL} -x ${Ip}:${Port} >> Curl_Out.txt
echo ":${Ip}:${URL}" >> Curl_Out.txt
done

awk -F":" '{if(($1*1000<8000)&&($2>0)&&($3=="200"||$3=="301"||$30=="302"||$3=="401")) {} else {print $0 >> "Curl_Out_1.txt"}}' Curl_Out.txt

if [ -s Curl_Out_1.txt ];then
Warning="`awk '{printf("%s#",$0)}' Curl_Out_1.txt`"
ssms ${Warning}
smail CURL_Monitor ${Warning}
fi


#备注：
#curl是一个命令行下的http下载工具，类似wget。与wget相似，它也可以通过发送指定的http header到服务器来判断服务的状态
#这里介绍一个使用curl监控页面可用性的方法。
#可以使用下面的命令，来采集页面的状态码。如果这条命令返回结果为200，说明服务正常。如果返回的是其他的页面，说明异常#。
#curl -o /dev/null -s -w %{http_code} http://zys.8800.org/
#-o 参数，是把下载的所有内容都重定向到/dev/null，-s命令，是屏蔽了curl本身的输出，而-w参数，是根据我们自己的需要，##自定义了curl的输出格式。
#使用这条命令，再配合邮件和短信，就可以实现对页面的可用性监控。将这个程序部署在全国各地的机器上，就可以对cdn网络进#行可用性监控。
#
#curl只返回服务器响应状态，不返回内容，返回200是正常的，其它的不正常，简单的命令如下：
#
#[coomix@localhost ~]$ echo `curl -o /dev/null -s -m 10 --connect-timeout 10 -w %{http_code} "http://www.coomix.ne#t/index.jsp"`
#200
#[coomix@localhost ~]$ echo `curl -o /dev/null -s -m 10 --connect-timeout 10 -w %{http_code} "http://www.coomix.ne#t/index5.jsp"`
#404
