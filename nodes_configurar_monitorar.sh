if [ ! -f "chave.pem" ];then 
	echo "ERRO - Cade a chave do cluster: chave.pem";
	exit 1 
fi 


if [ ! -f "nodes_IPs" ];then 
	echo "ERRO - Cade a lista de IPs  do cluster: nodes_IPs";
	exit 1 
fi 
execute_cluster () {
	for server in $(cat nodes_IPs); do 
		echo "executing on server: 	 	$server  command $1"
		ssh -i chave.pem $server "$1"
	done 
}

execute_cluster_background () {
	for server in $(cat nodes_IPs); do 
		echo "executing on server: 	 	$server  command $1"
		ssh -i chave.pem $server "$1"  &
	done 
}
enviar_arquivo () {
	for server in $(cat nodes_IPs); do 
		echo "enviando on server: 	 	$server  file $1"
		scp -i chave.pem $1  $server:
	done 
}

enviar_diretorio () {
	for server in $(cat nodes_IPs); do 
		echo "enviando on server: 	 	$server  file $1"
		scp -r  -i chave.pem $1  $server:
	done 
}


baixar_diretorio () {
	for server in $(cat nodes_IPs); do 
		echo "enviando on server: 	 	$server  file $1"
		mkdir $server
		scp -r  -i chave.pem  $server:$1 $server/. 
	done 
}


if [ "$1" == "configurar" ]; then 
	execute_cluster "hostname"
	execute_cluster "sudo sed -i 's/enabled=0/enabled=1/g'  /etc/yum.repos.d/epel.repo        "
	execute_cluster "cat /etc/yum.repos.d/epel.repo"
	execute_cluster "sudo yum repolist                                                      "
	execute_cluster "sudo yum install -y iotop                                              "
	execute_cluster "sudo yum install -y unzip                                              "
	execute_cluster "sudo yum install -y iftop                                              "
	execute_cluster "sudo apt-get install -y iotop                                          "
	execute_cluster "sudo apt-get install -y unzip                                          "
	execute_cluster "sudo apt-get install -y iftop                                          "
	enviar_arquivo monitoramento.sh
	enviar_diretorio monitores 
	exit 0
fi;


if [ "$1" == "monitorar" ]; then 
	execute_cluster_background "nohup ./monitoramento.sh $2 $3 &" 
	if [ "$2" == "stop" ]; then 
		baixar_diretorio "$3"
	fi 
	exit 0
fi 


	execute_cluster "ps aux | grep monitor | grep -v heartbeat  "
execute_cluster "rm -rf teste teste1 workload1 workload2"

echo "escolher entra as opcoes: monitorar e configurar "

exit 1 
