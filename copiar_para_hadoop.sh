#!/bin/bash
###
#  Parametros
###
MESES=12
date
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
for ANO in $(seq 2013 2018); do 
  CONT=1
  while [ "$CONT" -le $MESES ]; do
    if [ "$CONT" -le 9 ]; then
      CONT_S=0$CONT
    else
      CONT_S=$CONT
    fi
    echo "Copiando ${ANO}${CONT_S}_BolsaFamilia_Pagamentos.csv"
    hdfs dfs -copyFromLocal dados/${ANO}${CONT_S}_BolsaFamilia_Pagamentos.csv /input
    CONT=$(($CONT + 1))
  done
done
echo "Copia para o hadoop finalizada"
date
