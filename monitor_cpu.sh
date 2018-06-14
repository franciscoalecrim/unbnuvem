#!/bin/bash
while [ true ]; do
  echo `date +'%s'` `top -bc -d 1 -n 1 | grep -m1 -e '%Cpu'` >> monitoramento/cpu.txt
  sleep 1
done
