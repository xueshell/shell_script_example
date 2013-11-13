#! /bin/sh

website[0]='zufang.hfhouse.com/chuzu/'　　#网站1
mobile[0]='15955159890'　　　　　　　　　　 #对应网站1 手机号码

website[1]='oldhouse.hfhouse.com/chushou/' #同上2
mobile[1]='15955159890'                    #同上2

#以此类推，若网站过多 则可进行文件，或数据库读取方式

length=${#website[@]}   #获取网站总数量
for ((i=0; i<$length; i++)) #循环执行
do
   status=$(curl -I -m 10 -o /dev/null -s -w %{http_code} ${website[$i]})   #CURL 获取http状态码
   if [ "$status"x != "200"x ]; then      #检测是否为 200(正常)
    echo ${website[$i]} '=>' $status  
    #php /htdoc/jk/shell_monitor.php ${mobile[$i]} ${website[$i]}'=>AccessError!'  #执行PHP文件(使用PHP主要为了采用第三方短信类库，此处也可进行Mail发送)
   fi #结束if
done #结束 do

#执行：crontab -e
#写入内容：5 * * * * /shell path
#(上面是5分钟执行一次

