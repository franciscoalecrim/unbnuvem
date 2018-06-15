#!/bin/bash
rm -rf workload2/resultado_consolidado.txt
CONT=32
while [ "$CONT" != "0" ]; do
  echo $CONT $(grep -e "^${CONT}" workload2/resultado.txt | wc -l) >> workload2/resultado_consolidado.txt
  CONT=$(($CONT - 1))
done
