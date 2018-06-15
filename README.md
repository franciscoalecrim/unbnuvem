# UNB / Tópicos de Computação em Nuvem - 2018/01
### Projeto Prático

##### Professora 
Aleteia Patricia F. de Araújo Von Paumgartten

##### Alunos
- Hudson
- Francisco Keppler S. Alecrim
- Leonardo Rebouças de Carvalho
- Lucelia

##### Objetivo
Executar workloads hadoop em diferentes provedores de núvem

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
