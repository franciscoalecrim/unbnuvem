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
- Workload 1 - Calcular a quantidade de bolsas família pagos em 2017 por estado (FIXME - O resultado do workload precisa ser revalidado após nova base de dados.)
  
  ```
  Qtde de bolsas  Estado
  21510356        BA
  17631560        SP
  13462414        PE
  12457106        MG
  12284805        CE
  11601055        MA
  10969235        PA
  9384842 RJ
  6093673 PB
  5288845 PI
  4758758 AL
  4542636 AM
  4329379 PR
  4313072 RS
  4085884 RN
  3705041 GO
  3251315 SE
  2023333 ES
  1913055 MT
  1515803 MS
  1502019 TO
  1407727 SC
  1033412 RO
  1010360 AC
  967168  DF
  792596  AP
  548550  RR
  ```
  
- Workload 2 - Calcular a frequência de recebimentos de bolsa familia por NIS agrupado pela quantidade (FIXME - O resultado do workload precisa ser revalidado após nova base de dados.)
  
  *Nesse caso **11220885** pessoas receberam o bolsa família **12** vezes em 2017 e **12180822** apenas **uma** vez. Observe que **819** pessoas receberam o benefício **23** vezes*
  
  ```
  Qtde de bolsas recebidas Qtde de NIS
  32 2
  31 2
  30 3
  29 4
  28 5
  27 1
  26 4
  25 21
  24 16
  23 819
  22 740
  21 773
  20 858
  19 1727
  18 3361
  17 2299
  16 9239
  15 7130
  14 58038
  13 34272
  12 11220885
  11 217775
  10 318090
  9 210881
  8 353757
  7 258417
  6 860774
  5 960261
  4 430025
  3 385628
  2 380178
  1 12180822
  ```

##### Nuvens
CONFIGURAÇÃO 0 - Configuração utilizada durante a criação dos scripts:
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

CONFIGURAÇÃO 1 - Configuração utilizada durante coleta  dos scripts(1 master e 4 workers) - será chamado de COLETA 1 :
- Google Cloud - Região (us-east1-b - Carolina do Sul/US)
  - Serviço: Dataproc  
    - Master: 1 x 4 Cores 8 RAM HD 120Gb
    - Workers: 4 x 4 Cores 8 RAM HD 120Gb
  
- AWS - Região (Carolina do Norte/US)
  - Criação de KeyPair (para acessar às máquinas)
  - Criação de Grupo de Segurança (para liberar acesso à porta 22 SSH)
  - Serviço: EMR
    - Master: 1 x m4.large (4 Cores 8 RAM HD 120Gb)
    - Workers: 4 x m4.large (4 Cores 8 RAM HD 120Gb)


CONFIGURAÇÃO 2 - Configuração utilizada durante coleta  dos scripts(1 master e 8 workers) - será chamado de COLETA 2 :
- Google Cloud - Região (us-east1-b - Carolina do Sul/US)
  - Serviço: Dataproc  
    - Master: 1 x 4 Cores 8 RAM HD 120Gb
    - Workers: 8 x 4 Cores 8 RAM HD 120Gb
  
- AWS - Região (Carolina do Norte/US)
  - Criação de KeyPair (para acessar às máquinas)
  - Criação de Grupo de Segurança (para liberar acesso à porta 22 SSH)
  - Serviço: EMR
    - Master: 1 x m4.large (4 Cores 8 RAM HD 120Gb)
    - Workers: 8 x m4.large (4 Cores 8 RAM HD 120Gb)

CONFIGURAÇÃO 3 - Configuração utilizada durante coleta  dos scripts(1 master e 16 workers) - será chamado de COLETA 3 :
- Google Cloud - Região (us-east1-b - Carolina do Sul/US)
  - Serviço: Dataproc  
    - Master: 1 x 4 Cores 8 RAM HD 120Gb
    - Workers: 8 x 4 Cores 8 RAM HD 120Gb
  
- AWS - Região (Carolina do Norte/US)
  - Criação de KeyPair (para acessar às máquinas)
  - Criação de Grupo de Segurança (para liberar acesso à porta 22 SSH)
  - Serviço: EMR
    - Master: 1 x m4.large (4 Cores 8 RAM HD 120Gb)
    - Workers: 8 x m4.large (4 Cores 8 RAM HD 120Gb)
 
##### Utilização
- Aprovisionar a núvem
- Acessar a máquina master remota
- Baixar este projeto

  ```
  git clone https://github.com/leonardoreboucas/projetonuvem.git
  ou
  git clone https://github.com/franciscoalecrim/unbnuvem.git
  ```

  ```
  cd projetonuvem
  ou
  cd unbnuvem
  ```

- Baixar os dados do Portal da transparência
  ```
  ./baixar_dados.sh (FIXME - script precisa ser ajustado para baixar dados do site próximo do google via SSH ou WGET http://35.237.211.40/unbnuvem/dados/ )
  ```

- Se o provedor de nuvem for Amazon AWS 
  ```
   sudo -u hdfs hdfs dfsadmin -safemode leave
   ```

- Depois do download finalizado, copiar dados para o Hadoop utilizando script abaixo. 
  ```
  ./copiar_para_hadoop.sh
  ```

- Enquanto o download é realizado, prosseguir com configuração do ambiente. 

- A coleta no master e nodes é controlada pelo master, portanto para o master conseguir controlar a coleta nos nodes ele precisa conseguir realizar o SSH sem senha do master para dentro dos nodes. 

- Coleta no arquivo nodes_IPs os IPs internos dos nodes. Não precisa colocar o IP do master, somente os IPs internos dos nodes.
  ```
  vim nodes_IPs
  ```
- Gerar o par de chave pública e privada no master e distribuir essas chaves para os nodes. 
  ```
  ssh-keygen -t rsa 
  ```
- Copiar a chave pública para cada um dos nodes: 
  ```
  #executar no master - copiar o valor da chave inteiro
  cat ~/.ssh/id_rsa.pub 
  
  #executar em cada node - copiando a chave pública do master no arquivo de autorizações do node
  vim ~/.ssh/authorized_keys
  ```

- Testar script de coletas multiplas para ver se está conseguindo fazer SSH sem senha. O script vai entrar em cada uma das máquinas nodes e executar o comando "hostname" apresentando o nome de cada node. 
  ```
  ./nodes_configurar_monitorar.sh
  ```

- Realizar configuração caso consiga fazer os SSHs sem senha. O script vai entrar em cada um dos nodes e fazer a instalação dos softwares necessários para coleta e monitoramento do SO.
  ```
  ./nodes_configurar_monitorar.sh configurar
  ```
  
- O script de múltiplas execuções realizará 5 execuções dos scripts workload1.sh e workload2.sh e irá organizar os resultados em pastas com nome execucao<N>. 
  ```
  ./multiplas_execucoes.sh
  ```



##### Monitoramento
Os dados de monitoramentos serão gerados nos diretórios: [workload]/monitoramento e [workload]/<node name>
Monitores:
 CPU e Memória são coletados por meio do top. IO de disco coletado por meio do iotop. Taxa de rede coletao por meio do iftop. Gerando um arquivo com a coleta abaixo repetidas vezes. 
 ```
Mon Jun 25 16:19:43 UTC 2018
TEMPOS 1529943583
TEMPO 20180625161943
top - 16:19:43 up  1:35,  3 users,  load average: 0.42, 0.18, 0.20
Tasks: 141 total,   1 running, 133 sleeping,   7 stopped,   0 zombie
%Cpu(s):  3.1 us,  1.1 sy,  0.0 ni, 92.1 id,  3.6 wa,  0.0 hi,  0.1 si,  0.0 st
KiB Mem:   8197444 total,  7540068 used,   657376 free,    15128 buffers
KiB Swap:        0 total,        0 used,        0 free.  4282200 cached Mem
16:19:43 Total DISK READ :       0.00 K/s | Total DISK WRITE :       0.00 K/s
16:19:43 Actual DISK READ:       0.00 K/s | Actual DISK WRITE:       0.00 K/s
    TIME  TID  PRIO  USER     DISK READ  DISK WRITE  SWAPIN      IO    COMMAND
interface: eth0
IP address is: 10.140.0.4
MAC address is: 42:01:0a:8c:00:04
Listening on eth0
   # Host name (port/service if enabled)            last 2s   last 10s   last 40s cumulative
--------------------------------------------------------------------------------------------
   1 cluster-e948-m.c.ivory-nectar-208109.in  =>     3.64Kb     3.64Kb     3.64Kb       932B
     189.6.12.181                             <=       480b       480b       480b       120B
   2 cluster-e948-m.c.ivory-nectar-208109.in  =>       788b       788b       788b       197B
     cluster-e948-w-0.c.ivory-nectar-208109.  <=     1.72Kb     1.72Kb     1.72Kb       440B
   3 cluster-e948-m.c.ivory-nectar-208109.in  =>       372b       372b       372b        93B
     cluster-e948-w-1.c.ivory-nectar-208109.  <=     1.34Kb     1.34Kb     1.34Kb       342B
--------------------------------------------------------------------------------------------
Total send rate:                                     4.77Kb     4.77Kb     4.77Kb
Total receive rate:                                  3.52Kb     3.52Kb     3.52Kb
Total send and receive rate:                         8.30Kb     8.30Kb     8.30Kb
--------------------------------------------------------------------------------------------
Peak rate (sent/received/total):                     4.77Kb     3.52Kb     8.30Kb
Cumulative (sent/received/total):                    1.19KB       902B     2.07KB
============================================================================================

 ```
 

 O script de pós-processamento dos dados está na pasta resultados_organizados. Seguir a organização dos resultados conforme pasta já criada e utilizar scripts disponíveis na pasta. 