#! /bin/bash
#
# namecoind monitor shell
#
# @copyright btc.com
# @author Zhibiao Pan
# @since 2016-09
#
SROOT=$(cd $(dirname "$0"); pwd)
cd $SROOT

NAMECOIND_RPC="namecoin-cli "
#WANIP=`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'`
#WANIP=`curl https://api.ipify.org`
WANIP=`curl http://ipinfo.io/ip`

#NOERROR=`$NAMECOIND_RPC getinfo |  grep '"errors" : ""' | wc -l`
HEIGHT=`$NAMECOIND_RPC getinfo | grep "blocks" | awk '{print $2}' | awk -F"," '{print $1}'`
CONNS=`$NAMECOIND_RPC getinfo | grep "connections" | awk '{print $2}' | awk -F"," '{print $1}'`

SERVICE="bpool.namecoind.$WANIP"
VALUE="height:$HEIGHT;conn:$CONNS;"
MURL="http://monitor.bitmain.com/monitor/api/v1/message?service=$SERVICE&value=$VALUE"

if [[ $CONNS -ne 0 ]]; then
  curl --max-time 30 $MURL
  exit 0
fi
