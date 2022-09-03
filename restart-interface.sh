#------------------------------------------------------------------------------------
#---------------root@OpenWrt:~# cat wg-restart-interface.sh--------------------------
#------------------------------------------------------------------------------------

#!/bin/ash
# This file is responsible for restarting the network interface.
# Should be run once OFFLINE state is detected.

INTERFACE="wg0"

# syslog entry
logger -s "WIREGUARD TUNNEL KEEP ALIVE SYSTEM: Restarting the wireguard interface."

echo "SH RESTART IFACE DOWN"
ifdown $INTERFACE

sleep 2

echo "SH RESTART IFACE UP"
