#after release ,check file is rsynced yes or no 
#lixin@staff.sina.com.cn
#check example:
#curl "http://dpadmin.grid.sina.com.cn/api/validist.php?clustername=blog&checklist=dpooltools/md5sum_v2.php:45ee210dee818f959623b980e23963c1,dist_test:d41d8cd98f00b204e9800998ecf8427e&uuid=1411474160.170537339&mod=int_dpool_sina_com_cn&igtime=60"

#!/bin/bash
WOrkpath="$1"
declare -a NAME 
FName=""
FPath=""
MD5value=""
FList=$(find . -type f )


create_md5() {

#	FName=$( basename $1 )
#	FPath=$( dirname $1 )	
      	MD5value=$(md5sum $1 | cut -d ' ' -f1 )
#	echo  $FPath,$FName,$MD5value
	echo  $1:$MD5value
}



file_md5_array(){
	
	local n=0

	while read file
	do
      		NAME[$n]=$(create_md5 $file)
		n=$(($n+1))	
	done<<EOF
	$FList
EOF

}

file_md5_str(){
	
	local m=0

	while [ $m -le ${#NAME[@]} ]
	do
	#	echo ${NAME[m]}
		if [[ $m -eq 0 ]]
		then
			
       			CHeckFlist="${NAME[m]}"
			m=$(($m+1))
			continue
		fi
	##	
 		if [  ! -z "${NAME[$m]}" ]
		then
		
       			CHeckFlist="$CHeckFlist,${NAME[m]}"
			m=$(($m+1))
		fi
        ##
		
		m=$(($m+1))
		continue	

	done
	echo $CHeckFlist
}

uuid () {
	
	echo $(date +%s.%N)
}
return_check_blog_value(){
	
	clustername=""
	mod=""	
#	echo $str
curl "http://dpadmin.grid.sina.com.cn/api/validist.php?clustername=blog&checklist=$(file_md5_str)&uuid=$(uuid)&mod=blog_sina_com_cn&igtime=60"
}

return_chack_detail(){

	curl "http://dpadmin.grid.sina.com.cn/vapp/validist_recent.php?uuid=$(uuid)"
}
#cd $WOrkpath 

file_md5_array
	
return_check_blog_value

return_chack_detail

###
