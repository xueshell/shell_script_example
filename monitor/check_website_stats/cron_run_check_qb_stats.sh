#!/bin/sh

QB_CONF="/data0/qb_conf_backup/10.55.37.64/"
QB_GIT_BAK="/data0/git_hub_bitbucket/qb_git_backup/"


#update local qb conf
cd $QB_CONF
if ( svn up )
then

	/bin/cp -frap $QB_CONF $QB_GIT_BAK
	echo "copy shell to git repo!"
else
	echo " svn error"
fi
#backup qb in 10.210.132.20
cd $QB_GIT_BAK 
git add .
git commit -m " $date " .



for ((  i=90;i--;i>0 ))
do

	/bin/sh  /data0/git_hub_bitbucket/shell_script_example/curl_array_site_check.sh
	sleep 1h
	echo $i

done
