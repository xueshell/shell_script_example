#!/bin/bash
###FUCTIONS ####
function usage {
echo "usage: dp.sh -p <project-name> -d <commit-sha> [--not-simulate]"
echo "\t -p, --project \tThe name of the project to deploy (look at the configuration file)"
echo "\t -d, --deploy \tThe commit you want to deploy"
echo "\t --not-simulate \tReally deploy, it will not simulate!"
    echo "\t --no-colors \tDisable colors layout"
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
				;;
        -d | --deploy )
				shift
				DEPLOY_SELECTED=$1
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
