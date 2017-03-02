gpuf () {
   # git pull -f $1
   remote=${1:?"need remote to force pull from"}
 
   current_branch=$(git symbolic-ref -q HEAD)
   current_branch=${current_branch##refs/heads/}
   current_branch=${current_branch:-HEAD}
   if [ $current_branch = 'HEAD' ] ; then
       echo
       echo "On a detached head. Exiting..."
       exit 1
   fi 
 
   git fetch $remote $current_branch
   git reset --hard FETCH_HEAD
   git clean -df
}
