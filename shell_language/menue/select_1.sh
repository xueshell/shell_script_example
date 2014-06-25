echo "What is your favourite OS?"

select var in "Linux" "Gnu Hurd" "Free BSD" "Other";
do
break               #select本身就是一个循环，break是当选择后，就跳出循环
done

echo "You have selected $var"
