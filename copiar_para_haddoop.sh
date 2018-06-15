#!/bin/bash
###
#  Parametros
###
ANO=2017
MESES=12

echo "Limpando hadoop"

hdfs dfs -rm -r -f /input
hdfs dfs -mkdir /input

CONT=1
echo "Copiando arquivos"
while [ "$CONT" -le $MESES ]; do
  if [ "$CONT" -le 9 ]; then
    CONT_S=0$CONT
  else
    CONT_S=$CONT
  fi
  echo "Copiando ${ANO}${CONT_S}_BolsaFamiliaFolhaPagamento.csv"
  hdfs dfs -copyFromLocal dados/${ANO}${CONT_S}_BolsaFamiliaFolhaPagamento.csv /input
  CONT=$(($CONT + 1))
done
