#!/bin/bash
###
#  Parametros
###
ANO=2017
MESES=12
HADOOP_JAR=/usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar
WORKLOAD=workload1

echo "------------------------ Inicio ----------------------------"
rm -rf $WORKLOAD
hdfs dfs -rm -r -f /output*

###
#  Iniciando o monitoramento
###
./monitoramento.sh start $WORKLOAD
./nodes_configurar_monitorar.sh monitorar start $WORKLOAD

###
#  Execução do Wokload
###
echo "Executando WORKLOAD 1 - Contando a qtde de bolsas familia pagas em 2017 por estado"
hadoop jar $HADOOP_JAR grep /input/${ANO}*.csv /output/$WORKLOAD "^[A-Z][A-Z]\t"
echo "${WORKLOAD} finalizado"

###
#  Imprimindo o resultado
###
echo "Imprimindo resultado"
hdfs dfs -cat /output/$WORKLOAD/part-r-00000 > $WORKLOAD/resultado.txt
cat $WORKLOAD/resultado.txt

###
#  Finalizando o monitoramento
###
./nodes_configurar_monitorar.sh monitorar stop $WORKLOAD
./monitoramento.sh stop $WORKLOAD

echo "-------------------------------Fim-----------------------------"
