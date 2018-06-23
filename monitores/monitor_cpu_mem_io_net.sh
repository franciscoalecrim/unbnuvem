#!/bin/bash
WORKLOAD=$1
while [ true ]; do
  date  >> ${WORKLOAD}/monitoramento/cpu_mem_io_net.txt 2>&1
  echo "TEMPOS $(date +%s)" >> ${WORKLOAD}/monitoramento/cpu_mem_io_net.txt 2>&1
  echo "TEMPO $(date +%Y%m%d%H%M%S)" >> ${WORKLOAD}/monitoramento/cpu_mem_io_net.txt 2>&1
  sudo top -bc -d 1 -n 1 | head -n 5  >> ${WORKLOAD}/monitoramento/cpu_mem_io_net.txt 2>&1
  sudo iotop -b -a -k -t -o -n 1 -d 1   >> ${WORKLOAD}/monitoramento/cpu_mem_io_net.txt 2>&1
  sudo iftop -t -p -s 1   >> ${WORKLOAD}/monitoramento/cpu_mem_io_net.txt 2>&1
  sleep 1
done
