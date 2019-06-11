#!/bin/bash
# 0 * * * * /home/check_xu.sh
# Allan.Chan
DAT="`date +%Y%m%d`"
HOUR="`date +%H`"
DIR="`pwd`/oslog/host_${DAT}/${HOUR}"
DELAY=60
COUNT=60
# whether the responsible directory exist
if ! test -d ${DIR}
then
        `which mkdir` -p ${DIR}
fi
# general check
export TERM=linux
`which top` -b -d ${DELAY} -n ${COUNT} > ${DIR}/top_${DAT}.log 2>&1 &
# cpu check
`which sar` -u ${DELAY} ${COUNT} > ${DIR}/cpu_${DAT}.log 2>&1 &
#/usr/bin/mpstat -P 0 ${DELAY} ${COUNT} > ${DIR}/cpu_0_${DAT}.log 2>&1 &
#/usr/bin/mpstat -P 1 ${DELAY} ${COUNT} > ${DIR}/cpu_1_${DAT}.log 2>&1 &
# memory check
`which vmstat` ${DELAY} ${COUNT} > ${DIR}/vmstat_${DAT}.log 2>&1 &
# I/O check
`which iostat` ${DELAY} ${COUNT} > ${DIR}/iostat_${DAT}.log 2>&1 &
# network check
`which sar` -n DEV ${DELAY} ${COUNT} > ${DIR}/net_${DAT}.log 2>&1 &
#/usr/bin/sar -n EDEV ${DELAY} ${COUNT} > ${DIR}/net_edev_${DAT}.log 2>&1 &
# load average check
`which uptime` > ${DIR}/load_average_${DAT}.log 2>&1 &
