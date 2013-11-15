#! /bin/sh

QB_PATH="/data0/qb_conf_backup/10.55.37.64/quickbuild_conf/"
NUM=0


website[0]='http://10.55.37.64'
mobile[0]='15955159890'
#website[1]='oldhouse.hfhouse.com/chushou/'
#mobile[1]='15955159890'

for LINE in $( ls ${QB_PATH} )
do
	echo $NUM  $LINE
	NUM=$((NUM+1));
done



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


