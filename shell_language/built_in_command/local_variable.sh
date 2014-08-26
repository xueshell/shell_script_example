
#!/bin/bash

# local    
a() {
        local s=1
        echo $s
    }
# not local
b() {
        s=2
        echo $s
    }

    s=0
    a
    echo $s
    b
    echo $s
#    [root@bj_manager test]# ./ttt
#    1
#    0
#    2
#    2

