#!/bin/bash
dir_rev_bkp=/home/rev_bkp
path_mk=$(which mkdir)

     if [ -d "$dir_rev_bkp" ] ; then
               echo "OK.... Processando..."
          else
               $path_mk -p $dir_rev_bkp
     fi

