#------------------------------------------------------------------------------------
#------------------root@OpenWrt:~# cat wg-test.sh-----------------------------
#------------------------------------------------------------------------------------
#!/bin/ash
# This file is responsible for DNS check. The return value of its process
# determines the ONLINE/OFFLINE state.

IP_TO_PING=8.8.8.8
PACKET_COUNT=4

ONLINE=0

for i in `seq 1 $PACKET_COUNT`;
        do
                ping -c 1 -W 1 -q 192.168.66.1
                RETVAL=$?
				if [ $RETVAL -eq 0 ]; then
					ONLINE=1
				fi
        done

if [ $ONLINE -eq 1 ]; then
    # ONLINE
    echo "wg is connected"
    exit 0
else
    # OFFLINE
    echo "wg NOT connected"
    exit 1
fi
