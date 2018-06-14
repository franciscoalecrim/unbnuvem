#!/bin/bash
###
#  Parametros
###
ANO=2017
MESES=1
HADOOP_PATH=
HADOOP_BIN=
HADOOP_JAR=/usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar
echo "Iniciando o monitoramento"
rm -rf monitoramento
mkdir monitoramento
date +"%T" > monitoramento/inicio.txt
./monitor_cpu.sh &
echo $! > monitor_cpu.pid
./monitor_io.sh &
echo $! > monitor_io.pid
./monitor_memory.sh &
echo $! > monitor_memory.pid
#####
#  Baixando arquivos do portal da transparência
#####
echo "Baixando arquivos do portal da transparência\n"
./baixar_dados.sh
rm -f bolsa_consolidada.csv
CONT=1
while [ "$CONT" -le $MESES ]; do
  if [ "`ls | grep dados/${ANO}${CONT_S}_BolsaFamiliaFolhaPagamento.csv`" == "" ]; then
    echo "\nDescompactando dados/${ANO}$CONT_S.zip"
    unzip -o "dados/${ANO}${CONT_S}.zip"
  else
    echo "${ANO}${CONT_S}_BolsaFamiliaFolhaPagamento.csv já existe"
  fi
  cat "dados/${ANO}${CONT_S}_BolsaFamiliaFolhaPagamento.csv" >> bolsa_consolidada.csv
  CONT=$(($CONT + 1))
done
${HADOOP_BIN}hdfs dfs -mkdir /input
${HADOOP_BIN}hdfs dfs -rm /input/bolsa_consolidada.csv
${HADOOP_BIN}hdfs dfs -copyFromLocal bolsa_consolidada.csv /input
rm resultado.txt
#####
#  Contando valores dos estados
#####
echo "Contando valores dos estados\n"
declare -a arr=("AC" "AL" "AP" "AM" "BA" "CE" "DF" "ES" "GO" "MA" "MT" "MS" "MG" "PA" "PB" "PR" "PE" "PI" "RJ" "RN" "RS" "RO" "RR" "SC" "SP" "SE" "TO")
for i in "${arr[@]}"
do
   ESTADO=$i
   echo "Contando ${ESTADO}"
   ${HADOOP_BIN}hadoop jar $HADOOP_JAR grep /input/bolsa_consolidada.csv /output_${ESTADO} "${ESTADO}\t"
   ${HADOOP_BIN}hdfs dfs -cat /output_${ESTADO}/part-r-00000 >> resultado.txt
done
echo "Finalizando o monitoramento"
kill -9 $(cat monitor_cpu.pid)
kill -9 $(cat monitor_io.pid)
kill -9 $(cat monitor_memory.pid)
rm -rf *.pid
date +"%T" > monitoramento/final.txt
