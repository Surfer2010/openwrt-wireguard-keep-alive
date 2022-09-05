#------------------------------------------------------------------------------------
#---------------root@OpenWrt:~# cat wg-keep-alive.sh--------------------------
#------------------------------------------------------------------------------------

#!/bin/ash
# The main script file. I recommend putting into cron, e.g.:
# */2 * * * * /root/scripts/wg-keep-alive.sh

DIR=$( cd $(dirname $0) ; pwd -P )
LOG_FILE="$DIR/log-wg.txt"

OFFLINE_COUNT=$(cat $LOG_FILE | tail -4 | grep OFFLINE | wc -l)
OFFLINE_COUNT_TRESHOLD=4

SH_WG_TEST="$DIR/wg-test.sh"
SH_RESTART_INTERFACE="$DIR/wg-restart-interface.sh"

LINES_MAX=11000
LINES_MIN=6000
LINES_COUNT=$(wc -l $LOG_FILE | awk '{print $1}')

# if the log files gets huge, strip it, keep last LINES_MIN lines
if [[ "$LINES_COUNT" -ge "$LINES_MAX" ]]; then
   echo "$(tail -$LINES_MIN $LOG_FILE)" > $LOG_FILE
fi

# DNS test, it's result defines the ONLINE/OFFLINE state
`$SH_WG_TEST`

if [ $? -eq 1 ]; then
   echo "Ooops, Wireguard is down!"
   echo "$(date) Wireguard Tunnel down > RESTARTING INTERFACE" >> $LOG_FILE

   if [[ "$OFFLINE_COUNT" -ge "$OFFLINE_COUNT_TRESHOLD" ]]; then
      echo ">> Checking wireguard connectivity.." >> $LOG_FILE
      $SH_WG_TEST
   else
      echo ">> Restarting wireguard-interface.." >> $LOG_FILE
      $SH_RESTART_INTERFACE
   fi
else
   echo "Wireguard is okay!"
   echo "$(date) Wireguard aktiv" >> $LOG_FILE
fi
