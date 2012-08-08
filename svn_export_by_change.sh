#!/bin/sh
# svnxport.sh
#Export only modified files in SVN
# 
#  Copyright (C) 2009 by Julien Falconnet
#  http://www.falconnet.fr
# 
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  any later version.
#
#
#BEWARE : This script does not operate correctly with files whose filename contains spaces
# tests for parameters
if [ ! $1 ];then echo "svnxport : No source specified. Needs : source revision target_directory";exit;fi
if [ ! $2 ];then echo "svnxport : No revision specified. Needs : source revision target_directory";exit;fi
if [ ! $3 ];then echo "svnxport : No target_directory specified. Needs : source revision target_directory";exit;fi
# check if the target_directory allready exists
if [ -d $3 ];then echo "svnxport : target_directory '$3' allready exists. Remove it or change target_directory parameter.";exit;fi
echo "Processing : source($1), revision($2), target_directory($3)"
# we use svn diff to select changed files and only keep those updated or added.
# Then the 'for' separate status from filename (here is the problem with file with blanks)
for myfile in `svn diff -r $2:HEAD --summarize $1 | grep -e '^M ' -e '^A '`
do
   if  [  "$myfile" = "M"  -o  "$myfile" = "AM" -o "$myfile" = "A" -o "$myfile" = "." -o -d $myfile ]
   then
        # we ignore the status, and the directory to update
        continue
   else 
        #we focus on true changed files
        #first we create needed directories for the current file
        #note that we use a relative directory system
        outfile=`echo $myfile |sed "s|$1||g"`
        dir="$3/$outfile"
        mkdir -p $(dirname $dir)
        #then we export the file
        svn export $myfile $3/$outfile >> /dev/null
        echo "export $3/$outfile "
   fi
done
# List other files. Changed but not exported. Mainly the deleted ones.
# Usefull to know which files should be removed and follow weird comportment
echo "Watch for : "
svn diff -r $2:HEAD --summarize $1 | grep -v -e 'M ' -e 'A ' |sed "s|$1||g"

