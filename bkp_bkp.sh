#!/bin/bash

# Importar variaiveis com ferramentas do sistema
source tools.sh

# Importar dados que devem ser salvos
source directories.sh

# Importar configuracoes de usuario
source config.sh

#
# backup-X.sh - Programa feito para realizar o Backup completo do Snep na sua versao 3.X;
#
# Autor: Anderson Freitas
# Site: http://www.dialplanreload.com/
# Email: tmsi.freitas@gmail.com
#
#
#-----------------------------------------------------------------------------------------------
#
# [WARNING] A execucao e por sua conta e risco!
#
# Para executar, use;
#
# bash backup-X.sh
# ou
# ./backup-X.sh
#
# Este script tem como objetivo fazer o backup dos seguintes:
#
# * Banco de dados completo do Snep - COM CDR
# * Arquivos de configuracao do Asterisk
# * Arquivos de SOM do Asterisk
# * Arquivos de configuracao do SNEP
#
#
# OPCOES DE EXECUCAO - NAO ALTERE!!
#
#
# Execucao simples - ./backup-X.sh e execucao com -h

     if
          [ "$1" == "" ] ||
          [ "$1" == "-h" ] ; 

               then

          echo -en "\n**** Para iniciar o processo de backup\n"
          echo -en "Use: ./`basename $0` -bkp ou bash `basename $0` -bkp\n"
          echo -en "\n**** DEMAIS PARAMETROS ****\n"
          echo -en "\n -v Versao do programa"
          echo -en "\n -r Recomendacoes de uso"
          echo -en "\n -a Informacoes sobre autor\n\n"

     exit 0

     fi

#
# Versao do script (-v)

     if [ "$1" == "-v" ]; then

          echo -en "\n**** Programa para realizar backup automatico do Snep\n"
          echo -en "\n Versao $bkp_version\n\n"
          echo -en "\nPara mais opcoes, execute o script sem nenhum parametro ou com -h\n\n"

     exit 0

     fi

#
# Recomendacoes de uso (-r)

     if [ "$1" == "-r" ]; then

          echo -en "\n**** Para garantir uma melhor usabilidade, recomendo\n"
          echo -en "colocar este script na sua crontrab, permitindo que sua\n"
          echo -en "execucao seja diaria.\n\n"
          echo -en "Para fazer isso, edite a crontab do root e insira a linha\n"
          echo -en "abaixo:\n\n"
          echo -en "00 23 * * * /var/www/html/snep/scripts/`basename $0` -bkp\n"
          echo -en "\nLembre-se de ceder permissao de execucao (chmod +x) e\n"
          echo -en "tambem de mover o script para o diretorio informado acima.\n\n"

     exit 0

     fi

#
# Sobre o autor (-a)

     if [ "$1" == "-a" ]; then

          echo "
Nome: Anderson Freitas
Email: tmsi.freitas@gmail.com
Site: http://dialplanreload.com

Quem gurdará os guardioes?
"

     exit 0

     fi
#
# Execucao do backup (-bkp)

# abre if parametro -bkp

     if [ "$1" == "-bkp" ]; then

# GRUPO DE VARIAVEIS 1 - Comandos do sistema operacional que sao utilizados durante o programa
# Estas variaveis foram criadas para que o programa funcione em varios sistemas sem a necessidade de alteracao;
#
# [WARNING] ALTERE SOMENTE SE SOUBER O QUE ESTA FAZENDO

#date=$(date +%d%h%Y_%H%M%S_%N)
#path_mk=$(which mkdir)
#path_rm=$(which rm)
#path_ls=$(which ls)
#path_tar=$(which tar)
#path_mdump=$(which mysqldump)
#path_egrep=$(which egrep)
#path_awk=$(which awk)
#path_head=$(which head)
#path_tr=$(which tr)
#path_sed=$(which sed)

# GRUPO DE VARIAVEIS 2 - Neste trecho, temos todos os diretorios que serao salvos pelo programa;
# ALTERE SOMENTE SE SOUBER O QUE ESTA FAZENDO

#dir_bkp=/home/backup
#dir_ast=/etc/asterisk
#dir_ast_sounds=/var/lib/asterisk/sounds
#dir_snep=/var/www/html/snep

# GRUPO DE VARIAVEIS 3 - Neste outro trecho, temos os dados que podem mudar de servidor para servidor;
# Aqui voce pode e deve alterar conforme sua necessidade, mas claro, sempre com cautela;
#
# Usuario do banco de dados
user=snep
# Senha do banco de dados
passwd_user=sneppass
# Quantidade de backups armazenados
NUM_BKP=5

#Maos a massa!!!!
	
     if [ -d $dir_bkp ] ;

          then
               cd $dir_bkp
          else
               $path_mk $dir_bkp
     fi

# PROXIMA ACAO - BACKUP ASTERISK

     if [ -d $dir_bkp/asterisk ] ;

          then
               cd $dir_bkp/asterisk
          else
               $path_mk $dir_bkp/asterisk &&
               cd $dir_bkp/asterisk
     fi

               $path_tar -cvf asterisk_${date}.tar.gz $dir_ast

# EFETUAR ROTATIVIDADE DE ARQUIVOS

     ult_bkp_ast=$( 

          $path_ls -tl $dir_bkp/asterisk |
          $path_egrep -v total |
          $path_awk '{print $9}' |
          $path_head -$NUM_BKP |
          $path_tr '\n' '|' |
          $path_sed  "s/.$//"
     )

     for check_ast in `${path_ls} -lt $dir_bkp/asterisk |
          ${path_awk} '{print $9}' |
          ${path_egrep} -v "${ult_bkp_ast}"`;

     do

          `${path_rm} -f $dir_bkp/asterisk/$check_ast`;

     done

# PROXIMA ACAO - BACKUP ASTERISK SOUNDS

     if [ -d $dir_bkp/asterisk_sounds ] ;

          then

               cd $dir_bkp/asterisk_sounds

          else

               $path_mk $dir_bkp/asterisk_sounds &&
               cd $dir_bkp/asterisk_sounds

     fi

	$path_tar -cvf asterisk_sounds_${date}.tar.gz $dir_ast_sounds

# EFETUAR ROTATIVIDADE DE ARQUIVOS

     ult_bkp_ast_sounds=$(

          $path_ls -tl $dir_bkp/asterisk_sounds |
          $path_egrep -v total |
          $path_awk '{print $9}' |
          $path_head -$NUM_BKP |
          $path_tr '\n' '|' |
          $path_sed  "s/.$//"

     )

     for check_ast_sounds in `${path_ls} -lt $dir_bkp/asterisk_sounds |
          ${path_awk} '{print $9}' |
          ${path_egrep} -v "${ult_bkp_ast_sounds}"`; 	

     do 

          `${path_rm} -f $dir_bkp/asterisk_sounds/$check_ast_sounds`;

     done

# PROXIMA ACAO - BACKUP DO MYSQL

     if [ -d $dir_bkp/mysql ] ;

          then

               cd $dir_bkp/mysql

          else

               $path_mk $dir_bkp/mysql &&
               cd $dir_bkp/mysql

     fi

               $path_mdump -u$user -p$passwd_user snep > snep_${date}.sql 

# EFETUAR ROTATIVIDADE DE ARQUIVOS

     ult_bkp_mysql=$(

          $path_ls -tl $dir_bkp/mysql |
          $path_egrep -v total |
          $path_awk '{print $9}' |
          $path_head -$NUM_BKP |
          $path_tr '\n' '|' |
          $path_sed  "s/.$//"

     )	

     for check_mysql in `${path_ls} -lt $dir_bkp/mysql |
          ${path_awk} '{print $9}' |
          ${path_egrep} -v "${ult_bkp_mysql}"`;

     do

          `${path_rm} -f $dir_bkp/mysql/$check_mysql`;

     done

# PROXIMA ACAO - BACKUP DO SNEP

     if [ -d $dir_bkp/snep ] ;

          then

               cd $dir_bkp/snep/

          else

               $path_mk $dir_bkp/snep &&
               cd $dir_bkp/snep
     fi
	
               $path_tar -cvf snep_${date}.tar.gz $dir_snep --exclude=arquivos

# EFETUAR ROTATIVIDADE DE ARQUIVOS

     ult_bkp_snep=$(

          $path_ls -tl $dir_bkp/snep |
          $path_egrep -v total |
          $path_awk '{print $9}' |
          $path_head -$NUM_BKP |
          $path_tr '\n' '|' |
          $path_sed  "s/.$//"

     )

     for check_snep in `${path_ls} -lt $dir_bkp/snep |
          ${path_awk} '{print $9}' |
          ${path_egrep} -v "${ult_bkp_snep}"`;

     do 

          `${path_rm} -f $dir_bkp/snep/$check_snep`;

     done

# fecha parametro -bkp

exit 0

fi

##################################################################################################

# NEW FUNCTION: BACKUP REVERSE

     if [ "$1" == "-rev" ]; then


#Criando o diretorio para descompactar os bkps

dir_rev_bkp=/home/rev_bkp

     if [ -d "$dir_rev_bkp" ] ; then
               echo "OK.... Processando..."
          else
               $path_mk $dir_rev_bkp
     fi

# Opcoes de restauracao

          echo -en "\nDigite a opcao desejada\n"
          echo " ( 1 ) Recuperar backup somente do Asterisk"
          echo " ( 2 ) Recuperar backup somente do SNEP"
          echo " ( 3 ) Recuperar backup somente do MySQL do Snep"
          echo " ( 4 ) Recuperar backup somente do Asterisk Sounds"
          echo -en "\nInsira a opcao:\n"

          read opcao_bkp

# Se digitar A, vamos voltar o backup do Asterisk

               if [ "$opcao_bkp" != 1,2,3,4 ] ; then

                    echo "Por favor, tente novamente com uma opcao valida"

               fi

                    if [ "$opcao_bkp" == "1" ] ; then

                         echo "Beleza, vamos voltar o backup do Asterisk. Vou precisar que voce me informe qual arquivo de backup"
                         echo "Informe o diretorio completo, exemplo: /home/backup/asterisk/arquivodebackup.tar.gz"
                         echo "Lembre-se, o arquivo deve estar compactado no formato tar.gz"

                    read rev_ast
                              if [ "$rev_ast" != "" ] ; then

# Iniciando a substituicaoo de arquivos 


                                   $path_tar -xvf $rev_ast -C $dir_rev_bkp
                                   $path_mv $dir_ast $dir_ast-old/
                                   $path_mv $dir_rev_bkp/etc/asterisk/ $dir_ast/

                              else

                                   echo Por favor, tente novamente informando um caminho valido.

                              fi

                    fi









# Fechamento -rev
     exit 0

     fi
















##################################################################################################
# Thats all folk's
##################################################################################################
