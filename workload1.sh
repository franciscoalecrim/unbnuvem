#!/bin/bash
###
#  Parametros
###
ANO=2017
MESES=12
HADOOP_JAR=/usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar
WORKLOAD=workload1
sudo apt-get install iotop
echo "------------------------ Inicio ----------------------------"

rm -rf $WORKLOAD
mkdir -p $WORKLOAD/monitoramento

echo "Iniciando o monitoramento"
date +"%T" > $WORKLOAD/monitoramento/inicio.txt

./monitor_cpu.sh $WORKLOAD &
echo $! > $WORKLOAD/monitor_cpu.pid

./monitor_io.sh $WORKLOAD &
echo $! > $WORKLOAD/monitor_io.pid

./monitor_memory.sh $WORKLOAD &
echo $! > $WORKLOAD/monitor_memory.pid

echo "Executando WORKLOAD 1 - Contando a qtde de bolsas familia pagas em 2017 por estado"

hadoop jar $HADOOP_JAR grep /input/${ANO}*.csv /output/$WORKLOAD "^[A-Z][A-Z]\t"

echo "${WORKLOAD} finalizado"

echo "Imprimindo resultado"

hdfs dfs -cat /output/$WORKLOAD/part-r-00000

echo "Finalizando o monitoramento"
kill -9 $(cat $WORKLOAD/monitor_cpu.pid)
kill -9 $(cat $WORKLOAD/monitor_io.pid)
kill -9 $(cat $WORKLOAD/monitor_memory.pid)
rm -rf $WORKLOAD/*.pid
date +"%T" > $WORKLOAD/monitoramento/final.txt

echo "-------------------------------Fim-----------------------------"