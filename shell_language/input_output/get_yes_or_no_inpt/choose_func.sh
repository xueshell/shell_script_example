#!/bin/bash
function choose {
	
#	local default="$1"
	local default="pls in put somethine (Y/N)?"
#	local prompt="$2"
	local prompt="Please input answer for this question (Y/N)?"
	local choice_yes="$1"
	local choice_no="$2"
	local answer

	read -p "$prompt" answer
	[ -z "$answer" ] && answer="$default"

	case "$answer" in
	#	[yY] ) exec "$choice_yes"
		[yY] ) echo "$choice_yes"
			#error check
			;;
#		[nN] ) exec "$choice_no"
		[nN] ) echo "$choice_no"
			#error check
			;;
		* ) printf "%b  \n" "Unexpected answer '$answer!" >&2 ;;
	esac
}

choose "$1" "$2" 
