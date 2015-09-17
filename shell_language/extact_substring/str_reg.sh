#!/bin/bash
var="http://www.baidu.com/abc.html"
#       :命令 按个数截取
res=${var:0:4} #表示从0开始截到3结束
echo $res      #输出结果 http
res=${var:7}
echo $res       #输出结果 www.baidu.com/abc.html

#      #命令 获取右边字符 从左边开始配第一个
#      ## 命令 获取右边字符 从左边开始配最后一个
res=${var#*/}
echo $res        #输出结果 /www.baidu.com/abc.html
res=${var##*/}
echo $res   #输出结果 abc.html

#      %  命令 获取左边字符 从右边开始配第一个
#      %% 命令 获取左边字符 从右边开始配最后一个
res=${var%/*}
echo $s    #输出结果 http://www.baidu.com
res=${var%%/*}
echo $res  #输出结果 http:
#awk -F 命令
res=`echo $var | awk -F/ '{print $3}'`
echo $res  #输出结果 www.baidu.com
