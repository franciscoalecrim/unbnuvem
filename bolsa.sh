#!/bin/bash

###
#  Parametros
###
ANO=2017
HADOOP_PATH=/usr/local/hadoop/

#####
#  Baixando arquivos do portal da transparência
#####
rm -f bolsa_consolidada.csv
echo "Baixando arquivos do portal da transparência"
CONT=1
while [ "$CONT" -le 12 ]; do
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

$HADOOP_PATH/bin/hdfs dfs -mkdir /input
$HADOOP_PATH/bin/hdfs dfs -copyFromLocal bolsa_consolidada.csv /input
$HADOOP_PATH/bin/hadoop jar $HADOOP_PATH/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.6.5.jar grep /input/bolsa_consolidada.csv /output_ba 'BA\t'
$HADOOP_PATH/bin/hadoop jar $HADOOP_PATH/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.6.5.jar grep /input/bolsa_consolidada.csv /output_pe 'PE\t'

