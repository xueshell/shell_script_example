#!/bin/bash
function choose{
	
	local default="$1"
	local prompt="$2"
	local choice_yes="$3"
	local choice_no="$4"
	local answer

	read -p "$prompt" answer
	[ -z "$answer" ] && answer="$default"

	case "$answer" in
		[yY] ) exec "$choice_yes"
			#error check
			;;
		[nN] ) exec "$choice_no"
			#error check
			;;
		* ) printf "%b" "Unexpected answer '$answer!" >&2 ;;
	esac
} 
