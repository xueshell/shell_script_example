#!/bin/bash
## declare an array variable
declare -a array=("one" "two" "three" "four" "five" "lixin" "tim")

# get length of an array
arraylength=${#array[@]}

# use for loop read all values and indexes
for (( i=1; i<${arraylength}+1; i++ ));
do
  echo $i " / " ${arraylength} " : " ${array[$i-1]}
done

####
echo -e "\n"
echo -e "\n"
for k in ${array[@]}
do
   echo  $k 
done
#Output:

#!/bin/bash
# declare an array called array and define 3 vales
files=( "/etc/passwd" "/etc/group" "/etc/hosts" )
for i in "${files[@]}"
do
 #   echo $i
 cat	 $i
done
