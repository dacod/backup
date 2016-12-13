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

# GRUPO DE VARIAVEIS 3 - Neste outro trecho, temos os dados que podem mudar de servidor para servidor;
# Aqui voce pode e deve alterar conforme sua necessidade, mas claro, sempre com cautela;
#
#
# Usuario do banco de dados
#
user=snep
#
# Senha do banco de dados
#
passwd_user=sneppass
#
# Quantidade de backups armazenados
NUM_BKP=5
