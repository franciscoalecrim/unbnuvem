#!/bin/bash
###
#  Parametros
###
ANO=2017
MESES=1
HADOOP_PATH=
HADOOP_BIN=
HADOOP_JAR=/usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar
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
rm -f bolsa_consolidada.csv
echo "Baixando arquivos do portal da transparência\n"
CONT=1
while [ "$CONT" -le $MESES ]; do
  if [ "$CONT" -le 9 ]; then
    CONT_S=0$CONT
  else
    CONT_S=$CONT
  fi
  if [ "`ls | grep ${ANO}$CONT_S.zip`" == "" ]; then
    echo "\nBaixando ${ANO}${CONT_S}.zip"
    wget -O "${ANO}$CONT_S.zip" "http://arquivos.portaldatransparencia.gov.br/downloads.asp?a=${ANO}&m=${CONT_S}&consulta=BolsaFamiliaFolhaPagamento"
  else
    echo -e "\n${ANO}$CONT_S.zip já existe"
  fi

  if [ "`ls | grep ${ANO}${CONT_S}_BolsaFamiliaFolhaPagamento.csv`" == "" ]; then
    echo "\nDescompactando ${ANO}$CONT_S.zip"
    unzip -o "${ANO}${CONT_S}.zip"
  else
    echo "${ANO}${CONT_S}_BolsaFamiliaFolhaPagamento.csv já existe"
  fi

  cat "${ANO}${CONT_S}_BolsaFamiliaFolhaPagamento.csv" >> bolsa_consolidada.csv
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
date +"%T" > monitoramento/final.txt
