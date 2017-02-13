#!/bin/bash
# by shengting@staff.sina.com.cn
# TYPE : release rollback
 
TYPE=$1
SVNURL=$2
FILE_CHANGS=$3
DIR_SOURCE=$4
 
#TYPE=release rollback
#GITURL=http://lixin@10.210.132.20:8080/r/~lixin/git-change.git
#FILE_CHANGS=/home/shengting/testdir1/artifacts/gitdifflog.txt
#DIR_SOURCE=/home/shengting/testdir1/artifacts/source_code/201012/Release_v.1.5.35/service/plugin/
 
echo "*******************开始制作增量文件包*****************************"
echo -n "All Arguments::"
echo $* 
 
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
   echo "没有发现Git变更文件 : $FILE_CHANGS"
   exit 3
fi
if [ ! -d $DIR_SOURCE ]
then
   echo "没有发现目录 : $DIR_SOURCE"
   exit 4
fi
 
basename=`basename $DIR_SOURCE`
DIR_SOURCE=${DIR_SOURCE%$basename*}$basename
 
#echo "*****************"
#先找出git仓库后开始检出的目录，这个目录后的文件及目录是实际包目录
if [ 'release' == $TYPE ]
then
   strUrl=${SVNURL#http*.git} #匹配git仓库url，返回开始检出目录 可能返回空或以/开始的开始检出的目录
   echo ${strUrl}
   strUrl=${strUrl#/} #去掉/ 符号
   echo =========  strUrl "$strUrl" ================
else
   strUrl=$SVNURL
fi
#echo $strUrl  git 仓库中这个值都为空
 
# Determine whether there are updates
sed -i 's/^[[:space:]]*//' $FILE_CHANGS #删除所有空白开头的字符 -i 处理结果保存回原文件
#cat $FILE_CHANGS #显示git变更文件
strFile0=''
strFile0M=''
strFile0AD=''
 
strFile0M=`grep "^MODIFY $strUrl" $FILE_CHANGS` #以MODIFY开头的行 
#echo === strFile0M  $strFile0M  ===
strFile0M=`echo "$strFile0M" | awk '{print $2}'`
#echo strFile0M $strFile0M ===
#echo ========== strFile0M "$strFile0M" ==================
if [ -z "$strUrl" ] #-z 判断strUrl是否为null
then
   strFileM="$strFile0M"    
#    echo ++++++++ $strFileM
else
   strFileM=`echo "$strFile0M" | sed "s@$strUrl@@g"`  #把仓库地址结尾后,需要做包代码前的目录地址截取
   echo  ====== strFileM "$strFileM" ======
   echo ------
fi
 
if [ 'release' == $TYPE ]|| [ $strUrl != "" ]
then
   strFile0AD=`grep "^ADD $strUrl" $FILE_CHANGS`
#    echo wwwww $strFile0AD  wwwwwwwwwwww
else
   strFile0AD=`grep "^DELETE $strUrl" $FILE_CHANGS`
#    echo ---+++++ $trFile0AD
fi
strFile0AD=`echo "$strFile0AD" | awk '{print $2}'`
echo  ++++  strFile0AD $strFile0AD ----- 
#strFileAD=`echo "$strFile0AD" | sed "s@$strUrl@@g"` #git中strurl为空，删除了所有add的文件
strFileAD="$strFile0AD"
#echo ----  strFile0AD $strFile0AD ++++ 
 
strFile=${strFileM}${strFileAD}
echo strFile $strFile
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
