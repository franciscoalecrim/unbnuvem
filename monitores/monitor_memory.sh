#!/bin/bash
WORKLOAD=$1
while [ true ]; do
  echo `date +'%s'` `sudo top -bc -d 1 -n 1 | grep -m1 -e 'KiB Mem'` >> ${WORKLOAD}/monitoramento/memory.txt
  sleep 1
done
