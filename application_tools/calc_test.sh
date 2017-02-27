#!/bin/bash

# calc--A command line calculator that acts as a frontend to bc

scale=2


show_help()
{
    cat << EOF
        In addition to standard math functions, calc also supports:

        a % b       remainder of a/b
        a ^ b       exponential: a raised to the b power
        s(x)        sine of x, x in radians
        c(x)        cosine of x, x in radians
        a(x)        arctangent of x, in radians
        l(x)        natural log of x
        e(x)        exponential log of raising e to the x 
        j(n,x)      Bessel function of integer order n of x
        scale N     show N fractional digits (default = 2)
EOF
}

if [ $# -gt 0 ] ; then
exec scriptbc "$@"
fi

echo "Calc--a simple calculator. Enter 'help' for help, 'quit' to quit."

/bin/echo -n "calc> "

while read command args
do
    case $command
    in
        quit|exit) exit 0                                  ;;
        help|\?)   show_help                               ;;
        scale)     scale=$args                             ;;
        *)         scriptbc -p $scale "$command" "$args"  ;;
    esac

    /bin/echo -n "calc> "
done

echo ""

exit 0
