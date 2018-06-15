#!/bin/bash
COMANDO=$1
WORKLOAD=$2

if [ "$COMANDO" == "start" ]; then
  mkdir -p $WORKLOAD/monitoramento/pids/
  
  echo "Iniciando o monitoramento"
  date +"%T" > $WORKLOAD/monitoramento/inicio.txt
  
  echo "Iniciando o monitoramento da CPU"
    ./monitores/monitor_cpu.sh $WORKLOAD &
  echo $! > $WORKLOAD/monitoramento/pids/monitor_cpu.pid
  
  echo "Iniciando o monitoramento de I/O"
  ./monitores/monitor_io.sh $WORKLOAD &
  echo $! > $WORKLOAD/monitoramento/pids/monitor_io.pid
  
  echo "Iniciando o monitoramento de memoria"
  ./monitores/monitor_memory.sh $WORKLOAD &
  echo $! > $WORKLOAD/monitoramento/pids/monitor_memory.pid
  
  echo "Iniciando o monitoramento de rede"
  ./monitores/monitor_network.sh $WORKLOAD &
  echo $! > $WORKLOAD/monitoramento/pids/monitor_network.pid
fi

if [ "$COMANDO" == "stop" ]; then
  echo "Finalizando o monitoramento"
  kill -9 $(cat $WORKLOAD/monitoramento/pids/monitor_cpu.pid)
  kill -9 $(cat $WORKLOAD/monitoramento/pids/monitor_io.pid)
  kill -9 $(cat $WORKLOAD/monitoramento/pids/monitor_memory.pid)
  kill -9 $(cat $WORKLOAD/monitoramento/pids/monitor_network.pid)
  rm -rf $WORKLOAD/monitoramento/pids
  date +"%T" > $WORKLOAD/monitoramento/final.txt
fi
