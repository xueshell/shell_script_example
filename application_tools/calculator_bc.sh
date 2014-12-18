#!/bin/sh
#filename: testbc

var=$1
dd=$(echo $var|bc 2>/dev/null )
if [ "$var" != "$dd" ] || [ "$var" == "" ]; then
  echo "$var isn't number!"
elif echo $var | grep "/." > /dev/null 2>
then
#square=$(echo " $var * $var "|bc)
   square=$(echo " $var * $var  "|bc -l)
   echo "$var is a float number,square is:$square"
else
   square=$(echo "$var * $var" | bc)
   echo "$var is a int  number,square is:$square"
fi
