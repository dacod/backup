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
