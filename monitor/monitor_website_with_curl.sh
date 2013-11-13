#!/bin/bash

smail() {
mail -s "$1" gjw_apparitor@gmail.com <<EOF
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

