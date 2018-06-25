tempoinicial=""
resultado_csv="analisando_tempo.csv" 
echo "nuvem;execucao;workload;tempoinicial;tempofinal"  > $resultado_csv
	for file in $(find | grep master |  grep "inicio\|final" | grep -v 142 | grep -v 172); do 
	echo $file
	nuvem=$(echo $file | cut -f 2 -d\/ )
	execucao=$(echo $file | cut -f 3 -d\/ )
	workload=$(echo $file | cut -f 5 -d\/ )
	tipo=$(echo $file | cut -f 7 -d\/ )

	if [ $tipo == "final.txt" ]; then 
		tempofinal=$(cat $file)
		echo "$nuvem;$execucao;$workload;$tempoinicial;$tempofinal"  >> $resultado_csv
	else 
		tempoinicial=$(cat $file)
	fi 

	
	cat $file	
done
