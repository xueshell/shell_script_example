#!/bin/sh
cat $1 | sed -e 's/>/>
\/g' | grep '<a' | while IFS='"'  read a b c
do echo $b
done
