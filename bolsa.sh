#!/bin/bash
CONT=1
while [ "$CONT" != "10" ]; do
  wget -O "20170$CONT.zip" "http://arquivos.portaldatransparencia.gov.br/downloads.asp?a=2017&m=0$CONT&consulta=BolsaFamiliaFolhaPagamento"
  unzip "20170$CONT.zip"
  CONT=$(($CONT + 1))
done
