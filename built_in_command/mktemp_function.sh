#!/bin/bash

 mktemp_local()
 {
     tempfile=`mktemp temp.XXXXXX`                   #文件名格式　file.XXXXXX  6个大写Ｘ
    exec 3>$tempfile

     echo -e "\nThis script writes to local temp file $tempfile\n"
     echo "This is first line." >&3
     echo "This is second line." >&3
     echo "This is third line." >&3

     echo "Done creating tempfile.The contents are:"
     cat $tempfile

     rm -f $tempfile 2>/dev/null
 }

 mktemp_sys()
 {
     tempfile=`mktemp -t temp.XXXXXX`　　　　＃在系统临时目录下创建临时文件
    exec 3>$tempfile

     echo -e "\nThis script writes to  sys temp file $tempfile\n"
     echo "This is first line." >&3
     echo "This is second line." >&3
     echo "This is third line." >&3

     echo "Done creating tempfile.The contents are:"
     cat $tempfile

     rm -f $tempfile 2>/dev/null
 }

 mktemp_dir()
 {
     tempdir=`mktemp -d ./tmpd.XXXXXX`　　　　＃创建临时目录
    cd $tempdir
     tempf_a=`mktemp tempf.XXXXXX`　　　　　＃创建本地临时文件
    tempf_b=`mktemp tempf.XXXXXX`
     exec 7>$tempf_a
     exec 8>$tempf_b

     echo "This is a test file for temp file:$tempf_a" >&7
     echo "This is a test file for temp file:$tempf_b" >&8

     echo -e "\nTempdir contents:\n"
     echo "$tempf_a contents:"
     cat $tempf_a
     echo "$tempf_b contents:"
     cat $tempf_b
     cd -　　　　　　　　　　　　　　　　　　　＃返回原来的路径
    echo -e "\nThe tempd is here:"
     ls -d $tempdir
     echo -e "\nrm the tempd is here:"
     rm $tempdir -rf 2>/dev/null 
 }

 mktemp_local
 mktemp_sys 

mktemp_dir

#要点
#mktemp 命令及选项
#　　　没有选项时建立本地临时文件
#-t　　在系统的临时目录/tmp 下建立临时文件
#-d　　建立临时目录
