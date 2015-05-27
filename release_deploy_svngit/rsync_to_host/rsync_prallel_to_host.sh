#!/bin/sh

#
#

HOST=
RSYNC_MODULE=
USER=
PASSWD_FILE=

#get varlable
if [ $# -eq 0 ]
then
	echo " USAGE: $0  -u USER -p PASSWD -h HOST -m MODULE -t PASSWD_FILE  "
	exit 1
fi
while test $# -gt 0
do
	
	case $1 in
	-u | -U )
	shift
	USER="$1"
	;;

 	-p |-P )
        shift
        PASSWORD_FILE="$1"
        ;;

        -h | -H )
	shift	
	HOST="$1"
	;;
	
	-m| -M )
	shift
	RSYNC_MODULE="$1"
	;;
	
	-t |-T )
	shift
	PASSWORD_FILE="$1"
	;;
	
	* )
	echo " error"
	break
	;;

	esac
	shift
done
echo $HOST $RSYNC_MODULE $USER $PASSWD_FILE

#parse the ip list file


