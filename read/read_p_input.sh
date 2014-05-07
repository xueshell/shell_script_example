#!/bin/bash
TIP="Input  your name:"
read -p "$TIP" name 
NAME=$name
TIP="Input  your sex:"
read -p  "$TIP" sex
SEX=$sex

echo $NAME $sex >>file.txt

