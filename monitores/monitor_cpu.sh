#!/bin/bash
WORKLOAD=$1
while [ true ]; do
  echo `date +'%s'` `sudo top -bc -d 1 -n 1 | grep -m1 -e '%Cpu'` >> ${WORKLOAD}/monitoramento/cpu.txt
  sleep 1
done
