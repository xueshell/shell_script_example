#!/bin/bash

WPath="/data0/git_hub_bitbucket/shell_script_example/"
gitconfig="$WPath/.git/config"





cd $WPath
echo $PWD

cd_git_path(){
	if [ -f ./.git/config ] ; then
	#cp .git/config "$tmp_dir/.git/"
	echo "cd Git repo"	
	fi
}

get_git_url(){
	url=$( git config --get "remote.$1.url" )
	echo $url
}


for name in xueshell gitblit  gitbucket
do
 git add *
 git commit -m " $(date +%Y.%m.%d-%H:%M) " .
 git push $( get_git_url $name ) 
done
