# Tópicos de Computação em Nuvem - 2018/01
### Projeto Prático

##### Professora 
Aleteia

##### Alunos
- Hudson
- Francisco Alecrin
- Leonardo Rebouças de Carvalho
- Lucelia

##### Objetivo
Executar workloads hadoops em diferentes provedores de núvem

##### Workloads
- Workload 1 - Calcular a quantidade de bolsas família pagos em 2017 por estado
- Workload 2 - Calcular a frequência de recebimentos de bolsa familia por NIS agrupado pela quantidade

##### Utilização

- Aprovisionar a núvem com as seguintes características:
  - SO: Debian
  - 1 Master 2 CPU 10GB RAM HD 100GB
  - 3 Workers 2 CPU 10GB RAM HD 100GB

- Baixar este projeto
> git clone https://github.com/leonardoreboucas/projetonuvem.git
> cd projetonuvem

- Baixar os dados do Portal da transparência
> ./baixar_dados.sh

- Copiar dados para o Hadoop
> ./copiar_para_hadoop.sh

- Executar Workload 1
> ./workload1.sh

- Executar Workload 2
> ./workload2.sh

##### Monitoramento
Os dados de monitoramentos serão gerados nos diretórios: [workload]/monitoramento
