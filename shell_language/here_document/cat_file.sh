#!/bin/sh
usage() {
cat <<-USAGE
A Python shell with math functions and physical constants in the namespace.
usage: ${0##*/} [-h] [EXPR]
optional arguments:
EXPR expression to be evaluated
-h this text
Without arguments the python interpreter is started.
USAGE
exit 1
}

if [[ $@  -eq 0 ]]
then
	usage	
fi
