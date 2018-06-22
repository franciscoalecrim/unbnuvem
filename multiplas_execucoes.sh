for i in $(seq 1 5); do 
	echo execucao$i ; 
	./workload1.sh 
	./workload2.sh
	mkdir execucao$i
	mv workload1 execucao$i/. 
	mv workload2 execucao$i/. 
done 
