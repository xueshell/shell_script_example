#2.使用`seq 100`
#!/bin/bash
clear

for i in `seq 9999`
do
	if ((i%3==0))
	then
		echo $i
		continue
	fi
done
