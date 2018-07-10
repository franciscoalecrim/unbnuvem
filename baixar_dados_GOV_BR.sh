#!/bin/bash
###
#  Parametros
###
ANO=2017
MESES=12
mkdir dados
mkdir dados/pids


#####
#  Baixando arquivos do portal da transparência
#####
echo "Baixando arquivos do portal da transparência\n"
CONT=1
while [ "$CONT" -le $MESES ]; do
  if [ "$CONT" -le 9 ]; then
    CONT_S=0$CONT
  else
    CONT_S=$CONT
  fi
  if [ "`ls dados | grep ${ANO}$CONT_S.zip`" == "" ]; then
    echo "\nBaixando ${ANO}${CONT_S}.zip"
    wget -q -O "dados/${ANO}$CONT_S.zip" "http://arquivos.portaldatransparencia.gov.br/downloads.asp?a=${ANO}&m=${CONT_S}&consulta=BolsaFamiliaFolhaPagamento" & 
    echo $! > dados/pids/$!
  else
    echo -e "\n${ANO}$CONT_S.zip já existe"
  fi
  CONT=$(($CONT + 1))
done
echo "Aguardando"
sleep 5
cd dados/pids
while [ true ]; do
  echo "Verificando processos ativos..."
  for x in *; do
    echo $x
    if [ "$(ps -aux | grep wget | grep $x | wc -l)" == "0" ]; then
      rm $x  
    fi
  done
  if [ "$(ls)" == "" ]; then
    break
  else
   echo "." 
   sleep 5
  fi
done

while [ "$(ps -aux | grep wget | wc -l)" != "1" ]; do
  sleep 5
done

echo "Processo de copia Finalizado"