#!/usr/bin/env bash
date1="$1"
date2="$2"
echo "date1: $date1"
echo "date2: $date2"
tempdate=`date -d "-0 day $date1" +%F`
enddate=`date -d "-0 day $date2" +%F`
tempdateSec=`date -d "-0 day $date1" +%s`
enddateSec=`date -d "-0 day $date2" +%s`
echo "####################################"
echo 'tempdate: '$tempdate
echo 'enddate: '$enddate
#for i in `seq 1 130`; do
for i in `seq 1 300`; do
  if [[ $tempdateSec -lt $enddateSec ]]; then
    break
  fi
  echo $tempdate
# python pc_jibzhuanti_url.py $tempdate
tempdate=`date -d "-$i day $date1" +%F`
tempdateSec=`date -d "-$i day $date1" +%s`
done
