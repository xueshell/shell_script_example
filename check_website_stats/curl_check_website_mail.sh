#curl简述：curl是一个命令行下的http下载工具，类似wget。与wget相似，它也可以通过发送指定的http header到服务器来判断服务的状态。
# 这里介绍一个使用curl监控页面可用性的方法。
# 可以使用下面的命令，来采集页面的状态码。如果这条命令返回结果为200，说明服务正常。如果返回的是其他代码，说明异常。
#curl -o /dev/null -s -w %{http_code} http://www.btschina.com/
#-o 参数，是把下载的所有内容都重定向到/dev/null，-s命令，是屏蔽了curl本身的输出，而-w参数，是根据我们自己的需要，自定义了curl的输出格式。
#curl只返回服务器响应状态，不返回内容，返回200是正常的，其它的不正常，简单的命令如下：
#echo “curl -o /dev/null -s -m 10 –connect-timeout 10 -w %{http_code} http://www.btschina.com/”
#200

#如下为完整实例脚本：
#!/bin/bash
 #CHECK SLB

while :;do

sleep 10

URL=”http://www.btschina.com/SA_Test_Page.html”
HTTPOKID=`curl -o /dev/null -s -m 10 –connect-timeout 10 -w %{http_code} $URL`

if [ $HTTPOKID -eq 200 ];then

echo “OK!”

else

/bin/echo -e “故障,$URL无法访问,$HTTPOKID,请立即处理!” | sendEmail -f monitor@btschina.com -t test@btschina.com -u 故障,$URL无法访问,请立即处理! -s smtp.exmail.qq.com -xu monitor@btschina.com -xp one168 >> /tmp/err.txt 2>&1

fi

done

#多个网站监控实例：
#!/bin/bash
 #CHECK URL STATUS

while :;do

URL1=”http://www.btschina.com/SA_Test_Page.html”
URL2=”http://bbs.btschina.com/SA_Test_Page.html”

for i in $URL{1..2}

do

HTTPOKID=`curl -o /dev/null -s -m 10 –connect-timeout 10 -w %{http_code} $i`

if [ $HTTPOKID -eq "200" ];then

echo “”

else

/bin/echo -e “$i 无法访问,$HTTPOKID,请立即处理!” | sendEmail -f
 monitor@btschina.com -t test@btschina.com -u $i -s
 smtp.exmail.qq.com -xu monitor@btschina.com -xp one168 >> /tmp/err.txt 2>&1

fi

done

