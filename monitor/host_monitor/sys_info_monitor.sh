#!/bin/bash

hardware() {
                core=$(cat /proc/stat | grep cpu[0-99] | wc -l)
                cpuinfo=$(cat /proc/cpuinfo | grep "model name" | sort -u | awk -F ":" '{print $2}')
                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME hardware info ------------------"
                echo -e "$(tput bold)\E[33mCPU Info \E[37m"
                echo "$HOSTNAME Cpu Model:$cpuinfo"
                echo "$HOSTNAME Cpu core: $core"

                echo ""
                echo -e "$(tput bold)\E[33mMemory Info \E[37m"

                dmidecode | grep Memory -A15 | grep Manufacturer | sort -n | uniq -c | sed s/Manufacturer://g |  sed 's/ //g'| awk -v hostname="$HOSTNAME" '{print hostname " Memory Manufacturer: " $2" "$1" ea"}' 2>/dev/null

                dmidecode | grep Memory -A15 | grep "Size:"| grep -v "Range"| grep -v "Maximum" | grep -v Installed| sort -n | uniq -c |  sed 's/\t//g' | awk -v hostname="$HOSTNAME" '{print hostname" "$2" "$3" "$4" "$1" ea"}'

                echo ""
                echo -e "$(tput bold)\E[33mBoard Info \E[37m"

                dmidecode | grep "Base Board" -A10 | egrep 'Manufacturer|Product Name|Version|Serial Number' |  sed 's/\t//g' | awk -F ":" -v hostname="$HOSTNAME" '{print hostname " "$1":"$2}'

                echo -e "\E[36m------------------ $HOSTNAME hardware info ------------------ $(tput sgr0)"

                }

arp () {

                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME arp ------------------"
                echo -e "$(tput bold)\E[37m"
                /sbin/arp -e
                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME arp ------------------ $(tput sgr0)"

                }

route () {
                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME routing table ------------------"
                echo -e "$(tput bold)\E[37m"
                /sbin/route -n
                echo -e "\n"
                /sbin/route -n -C
                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME routing table ------------------ $(tput sgr0)"

                }

socket () {

                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME socket using ------------------"
                echo -e "$(tput bold)\E[37m"

                awk -v hostname="$HOSTNAME" '{print hostname" open port range = "$1" ~ "$2}' /proc/sys/net/ipv4/ip_local_port_range
                awk -v hostname="$HOSTNAME" '{port = $2 - $1}; END {print hostname " Max Possible Port = "port}' /proc/sys/net/ipv4/ip_local_port_range
                cat /proc/sys/net/netfilter/nf_conntrack_max /proc/sys/net/netfilter/nf_conntrack_count | xargs |awk -v hostname="$HOSTNAME" '{print hostname " nf_conntrack_max = " $1 " nf_conntrack_count = " $2}'
                awk '{print "Max thread = "$1}' /proc/sys/kernel/threads-max
                grep TCP /proc/net/sockstat
                grep -w UDP /proc/net/sockstat

                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME socket using ------------------ $(tput sgr0)"
                }

os () {

                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME OS info ------------------"
                echo -e "$(tput bold)\E[37m"

                cat /etc/redhat-release
                cat /proc/version

                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME OS info ------------------ $(tput sgr0)"

                }


cpu () {

                jippies_b=$(grep -w cpu /proc/stat | awk '{print $2+$3+$4+$5+$6+$7+$8+$9+$10}')
                user_b=$(grep -w cpu /proc/stat | awk '{print $2}')
                nice_b=$(grep -w cpu /proc/stat | awk '{print $3}')
                sys_b=$(grep -w cpu /proc/stat | awk '{print $4}')
                idle_b=$(grep -w cpu /proc/stat | awk '{print $5}')
                wait_b=$(grep -w cpu /proc/stat | awk '{print $6}')
                sleep 0.5
                jippies_a=$(grep -w cpu /proc/stat | awk '{print $2+$3+$4+$5+$6+$7+$8+$9+$10}')
                user_a=$(grep -w cpu /proc/stat | awk '{print $2}')
                nice_a=$(grep -w cpu /proc/stat | awk '{print $3}')
                sys_a=$(grep -w cpu /proc/stat | awk '{print $4}')
                idle_a=$(grep -w cpu /proc/stat | awk '{print $5}')
                wait_a=$(grep -w cpu /proc/stat | awk '{print $6}')

                jippies=$(expr $jippies_a - $jippies_b)
                user=$(echo "$user_a $user_b $jippies" |awk '{printf "%.2f",($1 - $2) * 100 / $3}' )
                nice=$(echo "$nice_a $nice_b $jippies" | awk '{printf "%.2f",($1 - $2) * 100 / $3}' )
                sys=$(echo "$sys_a $sys_b $jippies" | awk '{printf "%.2f",($1 - $2) * 100 / $3}' )
                iowait=$(echo "$wait_a $wait_b $jippies"| awk '{printf "%.2f",($1 - $2) * 100 / $3}' )
                idle=$(echo "$idle_a $idle_b $jippies" | awk '{printf "%.2f",($1 - $2) * 100 / $3}')

		
		echo -en "$(tput bold)\E[33m"
		echo -e "\t$HOSTNAME CPU Info"
		echo -e "$(tput sgr0)"

                awk '{printf "\033[1;37m" "Load average 1 min %.2f 5 min %.2f 15 min %.2f\n" , $1,$2,$3}' /proc/loadavg
                ps -A -o pcpu,comm | grep -v "CPU" | 
		awk 'BEGIN {cpu_sum = 0;} {cpu_sum += $1;} END {printf "Total CPU Used: %.2f %\n", cpu_sum;}'

		printf "CPU USER = $user %%\tCPU SYSTEM = $sys %%\nCPU NICE = $nice %%\tCPU IDLE = $idle %%\nCPU IOWAIT = $iowait %%\n"

                echo ""
                printf "\e[1;33mUsing Cpu Idle\e[0m\n"
                echo "1%----------------------------------------------------------------------------------------------100%"

                for i in `seq 1 $idle`

                        do
                                 printf "\e[1;32m*\e[0m"
                        done
                echo ""

                printf "\e[1;33mUsing Cpu User\e[0m\n"
                echo "1%----------------------------------------------------------------------------------------------100%"

                for u in `seq 1 $user`

                        do
                                 printf "\e[1;32m*\e[0m"
                        done
                echo ""

                printf "\e[1;33mUsing Cpu system\e[0m\n"
                echo "1%----------------------------------------------------------------------------------------------100%"

                for s in `seq 1 $sys`

                        do
                                 printf "\e[1;32m*\e[0m"
                        done
                echo ""

                printf "\e[1;33mUsing Cpu Nice\e[0m\n"
                echo "1%----------------------------------------------------------------------------------------------100%"

                for n in `seq 1 $nice`

                        do
                                 printf "\e[1;32m*\e[0m"
                        done
                echo ""

                printf "\e[1;33mUsing Cpu IO Wait\e[0m\n"
                echo "1%----------------------------------------------------------------------------------------------100%"

                for io in `seq 1 $iowait`

                        do
                                 printf "\e[1;32m*\e[0m"
                        done
                echo ""


		

                }


cpu_monit () {

	        echo -en "repeat? : "
	                read rep
	        echo -en "interval?(recommended 5sec) : "
        	        read interval

		if [ $interval -gt 0 ];

		then

		        for i in `seq 1 $rep`
                do
                        cpu

                        sleep $interval
                        printf "\ec"

                done

		else

		         for i in `seq 1 $rep`
                do
                        cpu

                        sleep 5
                        printf "\ec"

		done

fi
}

mem () {
                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME Memory Using info ------------------"
                echo -e "$(tput bold)\E[37m"

                grep MemTotal /proc/meminfo | awk  -v hostname="$HOSTNAME" '{ total = $2 }; END { print hostname " " "Total Memory: "total/1024 " MB"}'
                grep MemFree /proc/meminfo | awk  -v hostname="$HOSTNAME" '{ total = $2 }; END { print hostname " " "Free Memory: "total/1024 " MB"}'
                grep Buffers /proc/meminfo | awk  -v hostname="$HOSTNAME" '{ total = $2 }; END { print hostname " " "Buffers Memory: "total/1024 " MB"}'
                grep -w Cached /proc/meminfo | awk  -v hostname="$HOSTNAME" '{ total = $2 }; END { print hostname " " "Cached Memory: "total/1024 " MB"}'
                grep SwapCached /proc/meminfo | awk  -v hostname="$HOSTNAME" '{ total = $2 }; END { print hostname " " "SwapCached Memory: "total/1024 " MB"}'

                ps -A -o pmem,comm | grep -v "MEM" | awk -v hostname="$HOSTNAME" 'BEGIN {mem_sum = 0;} {mem_sum += $1;} END {print hostname " " "Total Memory Used: " mem_sum " ""%";}'
                ps -A -o vsz,comm | grep -v "VSZ" | awk -v hostname="$HOSTNAME" 'BEGIN {vsz_sum = 0;} {vsz_sum += $1;} END {print hostname " " "Total Virtual Memory Size: " vsz_sum/1024 " ""MB";}'
                ps -A -o rss,comm | grep -v "RSS" | awk -v hostname="$HOSTNAME" 'BEGIN {rss_sum = 0;} {rss_sum += $1;} END {print hostname " " "Total Resident Set Memory Size: " rss_sum/1024 " ""MB";}'

                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME Memory Using info ------------------ $(tput sgr0)"

                }

disk () {

                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME Disk info ------------------"
                echo -e "$(tput bold)\E[37m"

                grep -w cpu /proc/stat | awk -v hostname="$HOSTNAME" '{ wait = ( $6 * 100 ) / ( $2+$3+$4+$5+$6+$7+$8+$9+$10) }; END {print hostname" CPU IO WAIT = "wait"%\n"}'

                for i in $(grep -E '[s,h,xv]d[a-z][1,2,3,4,5,6,7,8,9,10]|[s,h,xv]d[a-z]' /proc/diskstats | awk '{print $3}')

                do

                reads_b=$(grep -w $i /proc/diskstats | awk '{print $4}')
                reads_merge_b=$(grep -w $i /proc/diskstats | awk '{print $5}')
                sectors_read_b=$(grep -w $i /proc/diskstats | awk '{print $6}')
                time_spent_reading_b=$(grep -w $i /proc/diskstats | awk '{print $7}')
                writes_b=$(grep -w $i /proc/diskstats | awk '{print $8}')
                writes_merged_b=$(grep -w $i /proc/diskstats | awk '{print $9}')
                sectors_written_b=$(grep -w $i /proc/diskstats | awk '{print $10}')
                time_spent_writing_b=$(grep -w $i /proc/diskstats | awk '{print $11}')
                io_ops_in_progress_b=$(grep -w $i /proc/diskstats | awk '{print $12}')
                io_time_b=$(grep -w $i /proc/diskstats | awk '{print $13}')
                io_time_weighted_b=$(grep -w $i /proc/diskstats | awk '{print $14}')
                sleep 1
                reads_a=$(grep -w $i /proc/diskstats | awk '{print $4}')
                reads_merge_a=$(grep -w $i /proc/diskstats | awk '{print $5}')
                sectors_read_a=$(grep -w $i /proc/diskstats | awk '{print $6}')
                time_spent_reading_a=$(grep -w $i /proc/diskstats | awk '{print $7}')
                writes_a=$(grep -w $i /proc/diskstats | awk '{print $8}')
                writes_merged_a=$(grep -w $i /proc/diskstats | awk '{print $9}')
                sectors_written_a=$(grep -w $i /proc/diskstats | awk '{print $10}')
                time_spent_writing_a=$(grep -w $i /proc/diskstats | awk '{print $11}')
                io_ops_in_progress_a=$(grep -w $i /proc/diskstats | awk '{print $12}')
                io_time_a=$(grep -w $i /proc/diskstats | awk '{print $13}')
                io_time_weighted_a=$(grep -w $i /proc/diskstats | awk '{print $14}')
                devices=$(grep -w $i /proc/diskstats | awk '{print $3}')

                reads=$(expr $reads_a - $reads_b)
                reads_merge=$(expr $reads_merge_a - $reads_merge_b)
                sectors_read=$(expr $sectors_read_a - $sectors_read_b)
                time_spent_reading=$(expr $time_spent_reading_a - $time_spent_reading_b)
                writes=$(expr $writes_a - $writes_b)
                writes_merged=$(expr $writes_merged_a - $writes_merged_b)
                sectors_written=$(expr $sectors_written_a - $sectors_written_b)
                time_spent_writing=$(expr $time_spent_writing_a - $time_spent_writing_b)
                io_ops_in_progress=$(expr $io_ops_in_progress_a - $io_ops_in_progress_b)
                io_time=$(expr $io_time_a - $io_time_b)
                io_time_weighted=$(expr $io_time_weighted_a - $io_time_weighted_b)

                printf "Devices : $devices\nreads : $reads\treads_merged : $reads_merge\tsectors_read : $sectors_read\ttime_spent_reading : $time_spent_reading\nwrites : $writes\twrites_merged : $writes_merged\tsectors_written : $sectors_written\ttime_spent_writing : $time_spent_writing\nio_ops_in_progress : $io_ops_in_progress\tio_time : $io_time\tio_time_weighted : $io_time_weighted\n\n"

                done


                pgpgin_b=$(grep pgpgin /proc/vmstat | awk '{print $2}')
                pgpgout_b=$(grep pgpgout /proc/vmstat | awk '{print $2}')
                pswpin_b=$(grep pswpin /proc/vmstat | awk '{print $2}')
                pswpout_b=$(grep pswpout /proc/vmstat | awk '{print $2}')
                sleep 1
                pgpgin_a=$(grep pgpgin /proc/vmstat | awk '{print $2}')
                pgpgout_a=$(grep pgpgout /proc/vmstat | awk '{print $2}')
                pswpin_a=$(grep pswpin /proc/vmstat | awk '{print $2}')
                pswpout_a=$(grep pswpout /proc/vmstat | awk '{print $2}')
                pgpgin=$(expr $pgpgin_a - $pgpgin_b)
                pgpgout=$(expr $pgpgout_a - $pgpgout_b)
                pswpin=$(expr $pswpin_a - $pswpin_b)
                pswpout=$(expr $pswpout_a - $pswpout_b)

                printf "Page IN : $pgpgin Page OUT : $pgpgout\nSwap IN : $pswpin Swap OUT : $pswpout\n\n"

#                grep pgpgin /proc/vmstat | awk -v hostname="$HOSTNAME" '{print "Page IN : "$2}'
#                grep pgpgout /proc/vmstat | awk -v hostname="$HOSTNAME" '{print "Page OUT : "$2}'
#                grep pswpin /proc/vmstat | awk -v hostname="$HOSTNAME" '{print "Swap IN : "$2}'
#                grep pswpout /proc/vmstat | awk -v hostname="$HOSTNAME" '{print "Swap OUT : "$2}'
                df -h

                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME Disk info ------------------ $(tput sgr0)"

                #Reference http://lxr.osuosl.org/source/Documentation/iostats.txt

                }


cpu_top10 () {
                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME CPU TOP 10 ------------------"
                echo -e "$(tput bold)\E[37m"

                ps -A -o pcpu,comm,pid | grep -v "CPU" | sort -n | tail -n10

                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME CPU TOP 10 ------------------ $(tput sgr0)"


                }

mem_top10 () {
                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME Memory TOP 10 ------------------"
                echo -e "$(tput bold)\E[37m"

                ps -A -o pmem,comm,pid | grep -v "MEM" | sort -n | tail -n10

                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME Memory TOP 10 ------------------ $(tput sgr0)"

                }

procinfo () {

                echo -n "Input Process Name : "

                read item
                pid=$(pidof $item)

                if [ -z "$item" ];

                then
                echo "usage :"
                echo -e "\tocinfo procinfo"
                echo -e "\tInput Process Name : nginx"
                echo    "-------------------------- nginx info --------------------------"
                echo
                echo    "Intergration-IMAGE nginx CPU Used : 0 %"
                echo    "Intergration-IMAGE nginx Memory Used : 0 %"
                echo    "Intergration-IMAGE nginx Virtual Memory Size : 2437.57 MB"
                echo    "Intergration-IMAGE nginx Resident Set Memory Size : 180.848 MB"
                echo    "-------------------------- nginx info --------------------------"

                else

                echo -e "$(tput bold)\E[36m"
                echo "-------------------------- $item info --------------------------"
                echo -e "$(tput bold)\E[37m"

                #ARGUMENT INFO
                ps -C $item -o args | grep -v "COMMAND" | awk -v hostname="$HOSTNAME" '{print hostname " ARGS : "$1" "$2" "$3}'

                #CPU INFO
                ps -C $item -o pcpu,comm | grep -v "CPU" | awk  -v hostname="$HOSTNAME" 'BEGIN {cpu_sum = 0;} {cpu_sum += $1;} END {print hostname " "$2" " "CPU Used : " cpu_sum " ""%";}'

                #Memory INFO
                ps -C $item -o pmem,comm | grep -v "MEM" | awk -v hostname="$HOSTNAME" 'BEGIN {mem_sum = 0;} {mem_sum += $1;} END {print hostname " "$2" " "Memory Used : " mem_sum " ""%";}'

                #Virtual Memory INFO
                ps -C $item -o vsz,comm | grep -v "VSZ" | awk -v hostname="$HOSTNAME" 'BEGIN {vsz_sum = 0;} {vsz_sum += $1;} END {print hostname " "$2" " "Virtual Memory Size : " vsz_sum/1024 " ""MB";}'

                #Resident Set Memory INFO
                ps -C $item -o rss,comm | grep -v "RSS" | awk -v hostname="$HOSTNAME" 'BEGIN {rss_sum = 0;} {rss_sum += $1;} END {print hostname " "$2" " "Resident Set Memory Size : " rss_sum/1024 " ""MB";}'

                echo -n "$HOSTNAME $item PID : $pid"


                echo -e "$(tput bold)\E[36m"
                echo "-------------------------- $item info -------------------------- $(tput sgr0)"

                fi



                }

fileuse () {
                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME File Handle ------------------"
                echo -e "$(tput bold)\E[37m"

                awk '{print "allocate file handle= "$1"\n""used file handle= "$2"\n""MAX file handle= "$3}' /proc/sys/fs/file-nr
                echo -e "$(tput bold)\E[36m"
                echo "------------------ $HOSTNAME File Handle ------------------ $(tput sgr0)"

                }

traffic () {

         echo -e "$(tput bold)\E[36m"
         echo "------------------ $HOSTNAME Traffic ------------------"
         echo -e "$(tput bold)\E[37m"

                for nic in $(ifconfig | awk '{print $1}' | egrep 'eth|bond|^em|lo')

                        do

                        in_start=$(cat /proc/net/dev| grep $nic | awk -F: '{print $2}' | awk '{print $1 }')
                        out_start=$(cat /proc/net/dev| grep $nic | awk -F: '{print $2}' | awk '{print $9 }')

                        in_packet_start=$(cat /proc/net/dev| grep $nic | awk -F: '{print $2}' | awk '{print $2 }')
                        out_packet_start=$(cat /proc/net/dev| grep $nic | awk -F: '{print $2}' | awk '{print $10 }')

                                sleep 1;

                        in_last=$(cat /proc/net/dev| grep $nic | awk -F: '{print $2}' | awk '{print $1 }')
                        out_last=$(cat /proc/net/dev| grep $nic | awk -F: '{print $2}' | awk '{print $9 }')

                        in_packet_last=$(cat /proc/net/dev| grep $nic | awk -F: '{print $2}' | awk '{print $2 }')
                        out_packet_last=$(cat /proc/net/dev| grep $nic | awk -F: '{print $2}' | awk '{print $10 }')

                        in_traffic=$(expr $in_last - $in_start)
                        out_traffic=$(expr $out_last - $out_start)
                        in_packet=$(expr $in_packet_last - $in_packet_start)
                        out_packet=$(expr $out_packet_last - $out_packet_start)

                                echo $nic IN_TRAFFIC : $(expr $in_traffic \* 8 / 1024) kbit/s
                                echo $nic OUT_TRAFFIC : $(expr $out_traffic \* 8 / 1024) kbit/s
                                echo ""
                                echo $nic IN_PACKET : $in_packet
                                echo $nic OUT_PACKET : $out_packet
                                echo ""

done

        echo -e "$(tput bold)\E[36m"
        echo "------------------ $HOSTNAME Traffic ------------------ $(tput sgr0)"

}

case "$1" in

hardware)
hardware
;;
arp)
arp
;;
route)
route
;;
socket)
socket
;;
os)
os
;;
cpu)
cpu
;;
cpu_monit)
cpu_monit 2>/dev/null
;;
mem)
mem
;;
disk)
disk
;;
ctop)
cpu_top10
;;
mtop)
mem_top10
;;
procinfo)
procinfo
;;
fileuse)
fileuse
;;
traffic)
traffic
;;
all)
hardware;arp;route;socket;os;cpu;mem;disk;cpu_top10;mem_top10;fileuse;traffic;
;;

*)

echo "Usage : kinfo [item]"
echo -e "\titem list\n\t-----------\n\thardware\n\tarp\n\troute\n\tsocket\n\tos\n\tcpu\n\tcpu_monit\n\tmem\n\tdisk\n\tctop\n\tmtop\n\tprocinfo\n\tfileuse\n\ttraffic"
exit 1
esac

