#!/bin/bash
#
# backup-X.sh - Programa feito para realizar o Backup completo do Snep na sua versao 3.X
#
# Autor: Anderson Freitas
# Site: http://www.dialplanreload.com/
# Email: tmsi.freitas@gmail.com
#
# Desenvolvido sob licensa GPL. 
# Fique a vontade para contribuir com a evolucao deste programa.
#
#-----------------------------------------------------------------------------------------------

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
