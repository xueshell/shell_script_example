#!/bin/sh

#
#

HOST=
RSYNC_MODULE=
USER=
PASSWD_FILE=


if [ $# -eq 0 ]
then
	echo " argument !"
	exit 1
fi
while test $# -gt 0
do
	case $1 in
        -h | -H)
	 shift
	HOST="$1"
	;;
	
	-m| -M)
	shift
	RSYNC_MODULE="$1"
	;;
	
	-p |-M)
	shift
	PASSWORD_FILE="$1"
	;;
	
	*)
	echo " error"
	break
	;;

	esac
	shift
done
echo $HOST $RSYNC_MODULE $USER $PASSWD_FILE
