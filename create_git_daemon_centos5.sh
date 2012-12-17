

#!/bin/sh



#centos 5
if uname -r | grep "el5"  >/dev/null
then
	continue 	
else
	exit 1	
fi

yum -y install git git-daemon gitweb

:
