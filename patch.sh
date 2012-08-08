#!/bin/bash


TYPE=$1
SVNURL=$2
FILE_CHANGS=$3
DIR_SOURCE=$4

#TYPE=release rollback
#SVNURL=https://svn.intra.sina.com.cn/icfunc/legacy/trunk/
#FILE_CHANGS=/home/testdir1/artifacts/svndifflog.txt
#DIR_SOURCE=/home/testdir1/artifacts/source_code/201012/Release_v.1.5.35/service/plugin/

##制作svn change log

echo "*******************开始制作增量文件包*****************************"
##echo $* 

if [[ 'release' != $TYPE && 'rollback' != $TYPE ]]
then
	echo "Please : sh deal.sh release|rollback  SVNURL diff_file source_code_dir"
	exit 1
fi
if [[ ! $SVNURL || ! $FILE_CHANGS || ! $DIR_SOURCE ]]
then
	echo "Please : sh deal.sh release|rollback  SVNURL diff_file source_code_dir"
	exit 2
fi
if [ ! -f $FILE_CHANGS ]
then
	echo "没有发现svn变更文件 : $FILE_CHANGS"
	exit 3
fi
if [ ! -d $DIR_SOURCE ]
then
	echo "Can't fine the file : $FILE_CHANGS"
	exit 4
fi

basename=`basename $DIR_SOURCE`
DIR_SOURCE=${DIR_SOURCE%$basename*}$basename

#echo "*****************"

if [ 'release' == $TYPE ]
then
	strUrl=${SVNURL#*.intra.sina.com.cn/}
	strUrl=/${strUrl#*/}
else
	strUrl=$SVNURL
fi
#echo $strUrl

# Determine whether there are updates
sed -i 's/^[[:space:]]*//' $FILE_CHANGS
strFile0=''
strFile0M=''
strFile0AD=''

strFile0M=`grep "^M" $FILE_CHANGS`
strFile0M=`echo "$strFile0M" | awk '{print $2}'`
strFileM=`echo "$strFile0M" | sed "s@$strUrl@@g"`

if [ 'release' == $TYPE ]
then
	strFile0AD=`grep "^A" $FILE_CHANGS`
else
	strFile0AD=`grep "^D" $FILE_CHANGS`
fi
strFile0AD=`echo "$strFile0AD" | awk '{print $2}'`
strFileAD=`echo "$strFile0AD" | sed "s@$strUrl@@g"`

strFile=${strFileM}${strFileAD}
if [ -z ${strFile:0:1} ]
then
        echo "****************** ****"
        echo "*****没有文件变更 !****"
        echo "*****没有文件变更 !****"
        echo "***********************"
	rm -fr "$DIR_SOURCE"
        exit 5
fi

# copy the files
if [ -d ${DIR_SOURCE}_tmp ]
then
	rm -rf ${DIR_SOURCE}_tmp
fi
mkdir -p ${DIR_SOURCE}_tmp

for file in $strFileM
do
	file=`echo "$file" | sed 's/[[:cntrl:]]*$//'`
	if [ -f ${DIR_SOURCE}/$file ]
	then
		strTmp=`dirname $file`
		if [ ! -d ${DIR_SOURCE}_tmp/$strTmp ]
		then
			mkdir -p ${DIR_SOURCE}_tmp/$strTmp
		fi

		cp ${DIR_SOURCE}/$file ${DIR_SOURCE}_tmp/$file
	fi

	if [ -d ${DIR_SOURCE}/$file ]
	then
		if [ ! -d ${DIR_SOURCE}_tmp/$file ]
		then
			mkdir -p ${DIR_SOURCE}_tmp/$file
		fi
	fi
done

for file in $strFileAD
do
	file=`echo "$file" | sed 's/[[:cntrl:]]*$//'`
	if [ -f ${DIR_SOURCE}/$file ]
	then
		strTmp=`dirname $file`
		if [ ! -d ${DIR_SOURCE}_tmp/$strTmp ]
		then
			mkdir -p ${DIR_SOURCE}_tmp/$strTmp
		fi

		cp ${DIR_SOURCE}/$file ${DIR_SOURCE}_tmp/$file
	fi

	if [ -d ${DIR_SOURCE}/$file ]
	then
		if [ ! -d ${DIR_SOURCE}_tmp/$file ]
		then
			mkdir -p ${DIR_SOURCE}_tmp/$file
			ls ${DIR_SOURCE}/$file/
			if [ 1 -lt `ls -l ${DIR_SOURCE}/$file/ | wc -l`  ]
			then
				cp -Rf ${DIR_SOURCE}/$file/* ${DIR_SOURCE}_tmp/$file/
			fi
		fi
	fi
done

rm -rf ${DIR_SOURCE}
mv ${DIR_SOURCE}_tmp ${DIR_SOURCE}

exit 0
