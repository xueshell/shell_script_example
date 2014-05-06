    #!/bin/bash
    # Shell Program to simulate a simple calculator
    # --------------------------------------------------------------------
    # This is a free shell script under GNU GPL version 2.0 or above
    # Copyright (C) 2005 nixCraft project.
    # Feedback/comment/suggestions : http://cyberciti.biz/fb/
    # -------------------------------------------------------------------------
    # This script is part of nixCraft shell script collection (NSSC)
    # Visit http://bash.cyberciti.biz/ for more information.
    # -------------------------------------------------------------------------
     
    a=$1
    op="$2"
    b=$3
     
    if [ $# -lt 3 ]
    then
    echo "$0 num1 opr num2"
    echo "opr can be +, -, / , x"
    exit 1
    fi
     
    case "$op" in
    +) echo $(( $a + $b ));;
    -) echo $(( $a - $b ));;
    /) echo $(( $a / $b ));;
    x) echo $(( $a * $b ));;
    *) echo "Error ";;
    esac
