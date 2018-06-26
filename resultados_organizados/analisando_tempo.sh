tempoinicial=""
resultado_csv="analisando_tempo.csv" 
echo "configuracao;nuvem;execucao;workload;tempoinicial;tempofinal"  > $resultado_csv
	for file in $(find | grep master |  grep "inicio\|final" | grep -v 142 | grep -v 172); do 
	echo $file

	configuracao=$(echo $file | cut -f 2 -d\/ )
	nuvem=$(echo $file | cut -f 3 -d\/ )
	execucao=$(echo $file | cut -f 4 -d\/ )
	workload=$(echo $file | cut -f 6 -d\/ )
	tipo=$(echo $file | cut -f 8 -d\/ )

	if [ $tipo == "final.txt" ]; then 
		tempofinal=$(cat $file)
		echo "$configuracao;$nuvem;$execucao;$workload;$tempoinicial;$tempofinal"  >> $resultado_csv
	else 
		tempoinicial=$(cat $file)
	fi 

	
	cat $file	
done
