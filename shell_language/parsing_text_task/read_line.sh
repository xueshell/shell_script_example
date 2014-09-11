#!/bin/bash




if [[ -f ./t.txt ]]
then
	read -p " Do you want to del this file ? [Y(y)/N(n)] "  choice 
		
	case "$choice" in
		Y|y)  unlink ./t.txt ; echo " rm t.txt in current folder " ;;
		N|n) echo "exit ! pls cat ./t.txt !!" ; exit 2 ;;
		*)  echo " argu error !"; exit 2 ;;
	esac
fi

cat <<EOF > ./t.txt 
M       quickbuild_conf/8837/Mon.zip
A       quickbuild_conf/8837/Tue.zip
M       quickbuild_conf/8819/Wed.zip
A       quickbuild_conf/8819/Thu.zip
M       quickbuild_conf/8819/Sun.zip
M       quickbuild_conf/8819/Sat.zip
M       quickbuild_conf/8819/Mon.zip
D       quickbuild_conf/8819/Tue.zip
M       quickbuild_conf/8838/Wed.zip
M       quickbuild_conf/8838/Thu.zip
M       quickbuild_conf/8838/Sun.zip
A       quickbuild_conf/8838/Sat.zip
M       quickbuild_conf/8838/Mon.zip
M       quickbuild_conf/8838/Tue.zip
M       quickbuild_conf/8839/Wed.zip
M       quickbuild_conf/8839/Thu.zip
D       quickbuild_conf/8839/Sun.zip
M       quickbuild_conf/8839/Sat.zip
A       quickbuild_conf/8839/Mon.zip
M       quickbuild_conf/8839/Tue.zip
EOF


while read a b 
do
	echo  -e " a $a \n"
	echo  -e " b $b  \n"
	echo "---------------------------------"
done<./t.txt
