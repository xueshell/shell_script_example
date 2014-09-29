#!/bin/bash


str="svn://192.168.1.199/wechat/code/branches/wechat/"

echo $str

str1=${str#svn://192.168.1.199/}

echo $str1
