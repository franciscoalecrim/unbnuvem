for i in $(seq 1 5); do 
	date
	echo execucao$i ; 
	./workload1.sh 
	./workload2.sh
	mkdir execucao$i
	date
	mv workload1 execucao$i/. 
	date
	mv workload2 execucao$i/. 
	date
	mv 172.* execucao$i/. 
	mv 10.* execucao$i/. 
done 
