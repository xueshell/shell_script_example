#!/bin/sh
for ((  i=100;i--;i>0 ))
do

	/bin/sh  /data0/git_hub_bitbucket/shell_script_example/curl_array_site_check.sh
	sleep 30
	echo $i

done
