#!/bin/bash

# exmaples:
# print diff files to stdout
# diff_script.sh src_folder dest_folder
#
# copy files to output_folder
# diff_script.sh src_folder dest_folder output_folder
#
# copy diff files to output_folder and create diff of files 
# diff_script.sh src_folder dest_folder output_folder diff
#

SRC_FOLDER="${1}"
DST_FOLDER="${2}"
# Output folder
OUTPUT="${3}"
# diff concrete files (diff/anythink)
INCL_DIFF="${4}"

FLSDIFF=`diff -rq ${SRC_FOLDER} ${DST_FOLDER}`

IFS=$'\n'
for res in $FLSDIFF;do
  if [[ "$OUTPUT" != "" ]];then
    diff_type=`echo $res | cut -d " " -f 1`

    if [[ "$diff_type" == "Files" ]];then      
      chgfile1=`echo $res | cut -d " " -f 4`
      chgdir1=`dirname "${chgfile1}"`
      mkdir -p "${OUTPUT}/${chgdir1}" 
      cp -v "${chgfile1}" "${OUTPUT}/${chgdir1}" 

      chgfile2=`echo $res | cut -d " " -f 2`
      chgdir2=`dirname "${chgfile2}"`
      mkdir -p "${OUTPUT}/${chgdir2}" 
      cp -v "${chgfile2}" "${OUTPUT}/${chgdir2}" 

      if [[ "${INCL_DIFF}" == "diff" ]];then
        diff "${chgfile1}" "${chgfile2}" > "${OUTPUT}/${chgdir1}/`basename ${chgfile1}`.diff"
        diff "${chgfile2}" "${chgfile1}" > "${OUTPUT}/${chgdir2}/`basename ${chgfile2}`.diff"
      fi
 
    elif [[ "$diff_type" == "Only" ]];then
      chgfile=`echo $res | cut -d " " -f 4`
      chgdir=`echo $res | cut -d " " -f 3 | tr -d ":"`
      mkdir -p "${OUTPUT}/${chgdir}" 
      cp -v "${chgdir}/${chgfile}" "${OUTPUT}/${chgdir}" 
    fi
  else
    echo $res
  fi
done

