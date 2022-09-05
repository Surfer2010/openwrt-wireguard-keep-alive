#------------------------------------------------------------------------------------
#---------------root@OpenWrt:~# cat wg-restart-interface.sh--------------------------
#------------------------------------------------------------------------------------
#!/bin/ash
# This file is responsible for restarting the router using reboot command.
# There is a stratery to write few lines into the log, so that grepping last lines
# returns less occurences of word OFFLINE. Too many occurences actually run this script.

INTERFACE="wg0"

# syslog entry
logger -s "INTERNET KEEP ALIVE SYSTEM: Restarting the wireguard interface."

echo "SH RESTART IFACE DOWN"
ifdown $INTERFACE

sleep 2

echo "SH RESTART IFACE UP"
ifup $INTERFACE
