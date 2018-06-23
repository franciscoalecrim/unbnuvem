#!/bin/bash
COMANDO=$1
WORKLOAD=$2

if [ "$COMANDO" == "start" ]; then
  mkdir -p $WORKLOAD/monitoramento/pids/
  
  echo "Iniciando o monitoramento"
  date +"%T" > $WORKLOAD/monitoramento/inicio.txt
  
  echo "Iniciando o monitoramento da CPU e Memory"
    nohup ./monitores/monitor_cpu_mem_io_net.sh $WORKLOAD &
  echo $! > $WORKLOAD/monitoramento/pids/monitor_cpu_mem_io_net.pid
fi

if [ "$COMANDO" == "stop" ]; then
  echo "Finalizando o monitoramento"
  kill -9 $(cat $WORKLOAD/monitoramento/pids/monitor_cpu_mem_io_net.pid)
  rm -rf $WORKLOAD/monitoramento/pids
  date +"%T" > $WORKLOAD/monitoramento/final.txt
fi
