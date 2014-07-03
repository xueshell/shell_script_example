#$ cat 1.txt
1,a
2,b
3,c
4,d
$ cat test.sh
#!/bin/bash
IFS=","
while read a b
do
        echo a=$a b=$b
done < 1.txt
$ sh test.sh 
a=1 b=a
a=2 b=b
a=3 b=c
a=4 b=d
