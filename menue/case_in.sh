#!/bin/bash
###FUCTIONS ####
function usage {
printf "\n usage: dp.sh -p <project-name> -d <commit-sha> [--not-simulate]"
printf "\n -p, --project \tThe name of the project to deploy (look at the configuration file)"
printf "\n -d, --deploy \tThe commit you want to deploy"
printf "\n --not-simulate \tReally deploy, it will not simulate!"
printf "\n --no-colors    \tDisable colors layout \n"
}

######### Start script ########
echo "Production deployment script (ver. 0.2)"

if [ "$1" == "" ]; then
usage
exit 1
fi

# Check parameters and Set defaults
SIMULATION=0
USE_COLOR=1
while [ "$1" != "" ]; do
	case $1 in
       	 -p | --project )
				shift
				PROJECT_NAME=$1
				echo $1
				echo $*
				;;
        -d | --deploy )
				shift
				DEPLOY_SELECTED=$1
				echo $1
				echo $*
				;;
        --not-simulate )
				SIMULATION=1
				;;
        --no-colors )
				USE_COLOR=0
				;;
	-h | --help )
				usage
				exit;;
        * )
				usage
				exit 1
    esac
    shift
done
