#linux 下shell加法操作总结：
#!/bin/bash
n=1;echo -n "$n "
let "n = $n + 1"
echo -n "$n "

: $((n = $n + 1))
echo -n "$n "


(( n = n +1 ))
echo -n "$n "


: $[ n = $n +1 ]
echo -n "$n "

n=$[ $n + 1 ]
echo -n "$n "

let "n++"
echo -n "$n "

(( n++ ))
echo -n "$n "

: $[ n++ ]
echo -n "$n "

echo


#运行结果：1 2 3 4 5 6 7 8 9
