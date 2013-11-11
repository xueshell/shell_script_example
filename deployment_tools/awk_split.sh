#!/bin/sh

FILE_LIST=/data0/git_hub_bitbucket/shell_script_example/deployment_tools/rsync_ip_module.list
#cat $FILE_LIST

cat $FILE_LIST | awk '/AA/,/#/ { print $1 }'

