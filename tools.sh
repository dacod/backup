#!/bin/bash

bkp_version=$(echo 1.2)

# GRUPO DE VARIAVEIS 1 - Comandos do sistema operacional que sao utilizados durante o programa
# Estas variaveis foram criadas para que o programa funcione em varios sistemas sem a necessidade de alteracao;
#
# [WARNING] ALTERE SOMENTE SE SOUBER O QUE ESTA FAZENDO

date=$(date +%d%h%Y_%H%M%S_%N)
path_mk=$(which mkdir)
path_rm=$(which rm)
path_ls=$(which ls)
path_tar=$(which tar)
path_mdump=$(which mysqldump)
path_egrep=$(which egrep)
path_awk=$(which awk)
path_head=$(which head)
path_tr=$(which tr)
path_sed=$(which sed)
path_mv=$(which mv)
