#!/bin/bash
./baixar_dados.sh
./copiar_para_hadoop.sh
./workload1.sh
./workload2.sh
