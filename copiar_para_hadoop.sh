#!/bin/bash
###
#  Parametros
###
ANO=2017
MESES=12

###
#  Limpando os dados no hadoop (caso hajam) 
###
echo "Limpando hadoop"
hdfs dfs -rm -r -f /input
hdfs dfs -rm -r -f /output*
hdfs dfs -mkdir /input

###
#  Copiando os arquivos para o HDFS
###
echo "Copiando arquivos para o HDFS"
CONT=1
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

echo "Copia para o hadoop finalizada"
