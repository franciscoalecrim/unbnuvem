# UNB / Tópicos de Computação em Nuvem - 2018/01
### Projeto Prático

##### Professora 
- Aleteia Patricia F. de Araújo Von Paumgartten

##### Alunos
- Hudson
- Francisco Keppler S. Alecrim
- Leonardo Rebouças de Carvalho
- Lucelia

##### Objetivo
- Executar workloads hadoop em diferentes provedores de núvem

##### Workloads
- Workload 1 - Calcular a quantidade de bolsas família pagos em 2017 por estado
- Workload 2 - Calcular a frequência de recebimentos de bolsa familia por NIS agrupado pela quantidade

##### Nuvens
- Google Cloud - Região (us-east1-b - Carolina do Sul/US)
  - Serviço: Dataproc  
    - Master: 1 x 4 Cores 8 RAM HD 32Gb
    - Workers: 1 x 4 Cores 8 RAM HD 32Gb
  
- AWS - Região (Carolina do Norte/US)
  - Criação de KeyPair (para acessar às máquinas)
  - Criação de Grupo de Segurança (para liberar acesso à porta 22 SSH)
  - Serviço: EMR
    - Master: 1 x m4.large (4 Cores 8 RAM HD 32Gb)
    - Workers: 1 x m4.large (4 Cores 8 RAM HD 32Gb)
 
##### Utilização
- Aprovisionar a núvem
- Acessar a máquina master remota
- Baixar este projeto

```
git clone https://github.com/leonardoreboucas/projetonuvem.git
```

```
cd projetonuvem
```

- Baixar os dados do Portal da transparência
```
./baixar_dados.sh
```
- Copiar dados para o Hadoop
```
./copiar_para_hadoop.sh
```
- Executar Workload 1
```
./workload1.sh
```

- Executar Workload 2
```
./workload2.sh
```

##### Monitoramento
Os dados de monitoramentos serão gerados nos diretórios: [workload]/monitoramento
Monitores:
 - CPU (top)
 ```
 echo `date +'%s'` `sudo top -bc -d 1 -n 1 | grep -m1 -e '%Cpu'`
 ```
 CPU (saída)
 ```
1529085524 %Cpu(s): 24.3 us, 18.6 sy, 0.0 ni, 50.2 id, 6.4 wa, 0.0 hi, 0.5 si, 0.0 st
1529085525 %Cpu(s): 24.3 us, 18.6 sy, 0.0 ni, 50.2 id, 6.4 wa, 0.0 hi, 0.5 si, 0.0 st
1529085526 %Cpu(s): 24.3 us, 18.6 sy, 0.0 ni, 50.1 id, 6.4 wa, 0.0 hi, 0.5 si, 0.0 st
1529085528 %Cpu(s): 24.3 us, 18.6 sy, 0.0 ni, 50.1 id, 6.4 wa, 0.0 hi, 0.5 si, 0.0 st
1529085529 %Cpu(s): 24.3 us, 18.6 sy, 0.0 ni, 50.1 id, 6.4 wa, 0.0 hi, 0.5 si, 0.0 st
1529085530 %Cpu(s): 24.3 us, 18.6 sy, 0.0 ni, 50.1 id, 6.4 wa, 0.0 hi, 0.5 si, 0.0 st
1529085531 %Cpu(s): 24.3 us, 18.6 sy, 0.0 ni, 50.1 id, 6.4 wa, 0.0 hi, 0.5 si, 0.0 st
1529085532 %Cpu(s): 24.3 us, 18.6 sy, 0.0 ni, 50.1 id, 6.4 wa, 0.0 hi, 0.5 si, 0.0 st
1529085534 %Cpu(s): 24.3 us, 18.6 sy, 0.0 ni, 50.1 id, 6.3 wa, 0.0 hi, 0.5 si, 0.0 st
1529085535 %Cpu(s): 24.3 us, 18.6 sy, 0.0 ni, 50.1 id, 6.3 wa, 0.0 hi, 0.5 si, 0.0 st
1529085536 %Cpu(s): 24.4 us, 18.6 sy, 0.0 ni, 50.1 id, 6.3 wa, 0.0 hi, 0.5 si, 0.0 st
1529085537 %Cpu(s): 24.4 us, 18.6 sy, 0.0 ni, 50.1 id, 6.3 wa, 0.0 hi, 0.5 si, 0.0 st
1529085538 %Cpu(s): 24.4 us, 18.6 sy, 0.0 ni, 50.1 id, 6.3 wa, 0.0 hi, 0.5 si, 0.0 st
1529085540 %Cpu(s): 24.4 us, 18.6 sy, 0.0 ni, 50.1 id, 6.3 wa, 0.0 hi, 0.5 si, 0.0 st
 ```
 
 
 
 - IO (iotop)
 ```
 echo `date +'%s'` `sudo iotop -b -a -k -t -o -n 1 -d 1 | grep "Actual DISK"` `sudo iotop -b -a -k -t -o -n 1 -d 1 | grep "Total DISK"` 
 ```
 
 - IO (saída)
 ```
1529085963 18:06:03 Actual DISK READ: 0.00 K/s | Actual DISK WRITE: 0.00 K/s 18:06:04 Total DISK READ : 0.00 K/s | Total
 DISK WRITE : 0.00 K/s
1529085965 18:06:05 Actual DISK READ: 0.00 K/s | Actual DISK WRITE: 0.00 K/s 18:06:05 Total DISK READ : 0.00 K/s | Total
 DISK WRITE : 59.95 K/s
1529085966 18:06:06 Actual DISK READ: 0.00 K/s | Actual DISK WRITE: 0.00 K/s 18:06:06 Total DISK READ : 0.00 K/s | Total
 DISK WRITE : 0.00 K/s
1529085967 18:06:08 Actual DISK READ: 0.00 K/s | Actual DISK WRITE: 0.00 K/s 18:06:08 Total DISK READ : 0.00 K/s | Total
 DISK WRITE : 0.00 K/s
1529085969 18:06:09 Actual DISK READ: 0.00 K/s | Actual DISK WRITE: 76.12 K/s 18:06:09 Total DISK READ : 0.00 K/s | Tota
l DISK WRITE : 161.47 K/s
1529085970 18:06:11 Actual DISK READ: 0.00 K/s | Actual DISK WRITE: 0.00 K/s 18:06:11 Total DISK READ : 0.00 K/s | Total
 DISK WRITE : 0.00 K/s
1529085972 18:06:12 Actual DISK READ: 0.00 K/s | Actual DISK WRITE: 0.00 K/s 18:06:12 Total DISK READ : 0.00 K/s | Total
 DISK WRITE : 0.00 K/s
1529085973 18:06:14 Actual DISK READ: 0.00 K/s | Actual DISK WRITE: 0.00 K/s 18:06:14 Total DISK READ : 0.00 K/s | Total
 DISK WRITE : 0.00 K/s  
 ```
 
 
 - Memoria (top)
 ```
 echo `date +'%s'` `sudo top -bc -d 1 -n 1 | grep -m1 -e 'KiB Mem'`
 ```
 
 - Memoria (saída)
 ```
1529085945 KiB Mem: 3800612 total, 3583308 used, 217304 free, 9372 buffers
1529085946 KiB Mem: 3800612 total, 3567392 used, 233220 free, 9372 buffers
1529085947 KiB Mem: 3800612 total, 3566340 used, 234272 free, 9372 buffers
1529085948 KiB Mem: 3800612 total, 3567408 used, 233204 free, 9372 buffers
1529085949 KiB Mem: 3800612 total, 3564536 used, 236076 free, 9372 buffers
1529085950 KiB Mem: 3800612 total, 3567580 used, 233032 free, 9380 buffers
1529085952 KiB Mem: 3800612 total, 3568128 used, 232484 free, 9380 buffers
1529085953 KiB Mem: 3800612 total, 3578440 used, 222172 free, 9380 buffers
1529085954 KiB Mem: 3800612 total, 3572576 used, 228036 free, 9380 buffers
1529085955 KiB Mem: 3800612 total, 3580352 used, 220260 free, 9388 buffers
1529085956 KiB Mem: 3800612 total, 3575640 used, 224972 free, 9388 buffers
1529085958 KiB Mem: 3800612 total, 3579748 used, 220864 free, 9388 buffers
1529085959 KiB Mem: 3800612 total, 3569808 used, 230804 free, 9388 buffers
1529085960 KiB Mem: 3800612 total, 3569636 used, 230976 free, 9396 buffers
1529085961 KiB Mem: 3800612 total, 3570148 used, 230464 free, 9396 buffers
1529085962 KiB Mem: 3800612 total, 3566556 used, 234056 free, 9396 buffers
1529085964 KiB Mem: 3800612 total, 3569828 used, 230784 free, 9396 buffers
 ```
  
 - Rede (iftop)
 ```
 echo `date +"%s"` `sudo iftop -t -p -s 1 | grep "send rate"` `sudo iftop -t -p -s 1 | grep "receive rate"`
 ``
 
 - Rede (saída)
 ```
 1529085871 Total send rate: 180Kb 180Kb 180Kb Total receive rate: 13.9Kb 13.9Kb 13.9Kb Total send and receive rate: 182Kb 182Kb 182Kb
1529085878 Total send rate: 31.0Kb 31.0Kb 31.0Kb Total receive rate: 19.3Kb 19.3Kb 19.3Kb Total send and receive rate: 49.1Kb 49.1Kb 49.1Kb
1529085886 Total send rate: 139Kb 139Kb 139Kb Total receive rate: 20.2Kb 20.2Kb 20.2Kb Total send and receive rate: 34.6Kb 34.6Kb 34.6Kb
1529085892 Total send rate: 67.9Kb 67.9Kb 67.9Kb Total receive rate: 20.6Kb 20.6Kb 20.6Kb Total send and receive rate: 98.4Kb 98.4Kb 98.4Kb
1529085898 Total send rate: 155Kb 155Kb 155Kb Total receive rate: 15.9Kb 15.9Kb 15.9Kb Total send and receive rate: 23.6Kb 23.6Kb 23.6Kb
1529085904 Total send rate: 161Kb 161Kb 161Kb Total receive rate: 12.4Kb 12.4Kb 12.4Kb Total send and receive rate: 18.8Kb 18.8Kb 18.8Kb
1529085910 Total send rate: 30.5Kb 30.5Kb 30.5Kb Total receive rate: 20.2Kb 20.2Kb 20.2Kb Total send and receive rate: 61.0Kb 61.0Kb 61.0Kb
1529085917 Total send rate: 6.37Kb 6.37Kb 6.37Kb Total receive rate: 30.8Kb 30.8Kb 30.8Kb Total send and receive rate: 76.3Kb 76.3Kb 76.3Kb
1529085925 Total send rate: 75.2Kb 75.2Kb 75.2Kb Total receive rate: 22.4Kb 22.4Kb 22.4Kb Total send and receive rate: 58.9Kb 58.9Kb 58.9Kb
1529085931 Total send rate: 64.5Kb 64.5Kb 64.5Kb Total receive rate: 10.1Kb 10.1Kb 10.1Kb Total send and receive rate: 14.2Kb 14.2Kb 14.2Kb
 ```
 
 
