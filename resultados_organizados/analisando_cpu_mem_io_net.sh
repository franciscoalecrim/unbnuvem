tempoinicial=""
resultado_csv="analisando_cpu_mem_io_net.csv" 
echo "nuvem;execucao;workload;maquina;ordem;data em segundos;data YYYYMMDDhhmmss;CPU US;CPU SY;CPU NI;CPU ID;CPU WA;CPU HI;CPU SI;CPU ST;MEM TOTAL;MEM USED;MEM FREE;MEM BUFFER;SWAP TOTAL;SWAP USED;DISK TOTAL READ;DISK TOTAL WRITE;DISK CURRENT READ;DISK CURRENT WRITE;NET SEND 2SECS;NET RECEIVE 2SEC; NET SEND RECEIVE 2S;"  > $resultado_csv
for file in $(find | grep monitoramento |  grep "cpu_mem" | grep -v "pid" | sort -u ); do 
	echo $file
	nuvem=$(echo $file | cut -f 2 -d\/ )
	execucao=$(echo $file | cut -f 3 -d\/ )
	workload=$(echo $file | cut -f 5 -d\/ )
	tipo=$(echo $file | cut -f 7 -d\/ )
	maquina=$(echo $file | cut -f 4 -d\/ )
	line_5="";	
	line_4="";	
	line_3="";	
	line_2="";
	line_1="";
	atual="";
	datas="";
	data="";
	ordem=-1;
	cpu_us="";
	cpu_sy="";
	cpu_ni="";
	cpu_id="";
	cpu_wa="";
	CPU_HI="";
	CPU_SI="";
	CPU_ST="";
	MEM_TOTAL="";
	MEM_USED="";
	MEM_FREE="";
	DISK_TOTAL_READ="";
	DISK_TOTAL_WRITE="";
	NET_SEND_2SECS="";
	NET_RECEIVE_2SEC="";
	NET_SEND_RECEIVE_2S="";
	for line in $(cat $file); do
		if [ "$atual" == "TEMPOS"  ]; then
			ordem=$((ordem + 1))
			echo "$nuvem;$execucao;$workload;$maquina;$ordem;$datas;$data;$cpu_us;$cpu_sy;$cpu_ni;$cpu_id;$cpu_wa;$CPU_HI;$CPU_SI;$CPU_ST;$MEM_TOTAL;$MEM_USED;$MEM_FREE;$MEM_BUFFER;$SWAP_TOTAL;$SWAP_USED;$DISK_TOTAL_READ;$DISK_TOTAL_WRITE;$DISK_CURRENT_READ;$DISK_CURRENT_WRITE;$NET_SEND_2SECS;$NET_RECEIVE_2SEC;$NET_SEND_RECEIVE_2S;" >> $resultado_csv 
		fi
		line_5=$line_4;
		line_4=$line_3;
		line_3=$line_2;
		line_2=$line_1;
		line_1=$atual
		atual=$line
		#echo "$line_5 $line_4 $line_3 $line_2 $line_1 $atual"
		if [ "$line_1" == "TEMPOS" ]; then
			datas=$atual;
		fi
		if [ "$line_1" == "TEMPO" ]; then
			data=$atual;
		fi
		if [ "$line_2" == "Cpu(s):" ]; then 
			cpu_us=$(echo $line_1 | sed s/us,//g);
			cpu_sy=$(echo $atual | sed s/sy,//g);
		fi 
		if [ "$line_5" == "Mem:" ]; then 
			MEM_TOTAL=$(echo $line_4);
			MEM_USED=$(echo $line_2);
			MEM_FREE=$(echo $atual);
		fi 
		if [ "$line_3" == "DISK" -a "$line_2" == "READ:" ]; then 
			DISK_TOTAL_READ=$(echo "$line_1$atual");
		fi 
		if [ "$line_3" == "DISK" -a "$line_2" == "WRITE:" ]; then 
			DISK_TOTAL_WRITE=$(echo "$line_1$atual");
		fi 
		if [ "$line_2" == "send" -a "$line_1" == "rate:" ]; then 
			NET_SEND_2SECS=$atual;
		fi
		if [ "$line_3" == "Total" -a "$line_2" == "receive" -a "$line_1" == "rate:" ]; then 
			NET_RECEIVE_2SEC=$atual;
		fi
		if [ "$line_4" == "send" -a "$line_2" == "receive" ]; then 
			NET_SEND_RECEIVE_2S=$atual;
		fi
	done;
	ordem=$((ordem + 1))
	echo "$nuvem;$execucao;$workload;$maquina;$ordem;$datas;$data;$cpu_us;$cpu_sy;$cpu_ni;$cpu_id;$cpu_wa;$CPU_HI;$CPU_SI;$CPU_ST;$MEM_TOTAL;$MEM_USED;$MEM_FREE;$MEM_BUFFER;$SWAP_TOTAL;$SWAP_USED;$DISK_TOTAL_READ;$DISK_TOTAL_WRITE;$DISK_CURRENT_READ;$DISK_CURRENT_WRITE;$NET_SEND_2SECS;$NET_RECEIVE_2SEC;$NET_SEND_RECEIVE_2S;" >> $resultado_csv 
done
