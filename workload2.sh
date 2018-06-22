#!/bin/bash
###
#  Parametros
###
ANO=2017
MESES=12
HADOOP_JAR=/usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar
WORKLOAD=workload2

echo "------------------------ Inicio ----------------------------"
rm -rf $WORKLOAD
hdfs dfs -rm -r -f /output*

###
#  Iniciando o monitoramento
###
./monitoramento.sh start $WORKLOAD

###
#  Execução do Workload
###
echo "Executando WORKLOAD 2 - Contando as ocorrencias de NIS em 2017"
hadoop jar $HADOOP_JAR grep /input/${ANO}*.csv /output/$WORKLOAD "\t\d\d\d\d\d\d\d\d\d\d\d\d\d\d\t"
hdfs dfs -cat /output/$WORKLOAD/part-r-00000 > $WORKLOAD/resultado.txt
echo "Consolidando os dados"
rm -rf workload2/resultado_consolidado.txt
CONT=32
while [ "$CONT" != "0" ]; do
  echo $CONT $(grep -e "^${CONT}" workload2/resultado.txt | wc -l) >> workload2/resultado_consolidado.txt
  CONT=$(($CONT - 1))
done

###
#  Imprimindo o resultado
###
echo "Imprimindo resultado"
cat workload2/resultado_consolidado.txt

echo "${WORKLOAD} finalizado"

###
#  Finalizando o monitoramento
###
./monitoramento.sh stop $WORKLOAD

echo "-------------------------------Fim-----------------------------"
