#! /bin/sh

website[0]='zufang.hfhouse.com/chuzu/'
mobile[0]='15955159890'
website[1]='oldhouse.hfhouse.com/chushou/'
mobile[1]='15955159890'

length=${#website[@]} 
for ((i=0; i<$length; i++)) 
do
   status=$(curl -I -m 10 -o /dev/null -s -w %{http_code} ${website[$i]})  
   if [ "$status"x != "200"x ]; then      #
    echo ${website[$i]} '=>' $status  
    #
   fi #
done #

#crontab -e
#5 * * * * /shell path


