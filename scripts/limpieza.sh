#!/bin/bash

#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/&gt;.

#Script de Limpieza de sistemas ArchLinux ¡Altamente mejorable!

#Obtener el espacio ocupado antes de la limpieza
# einicial=$(du -b -s / | cut -f1)
clear
echo “LIMPIEZA DEL SISTEMA”

#Comprobamos si el usuario es Root
if [ $(whoami) = "root" ]; then
#Todas las tareas que se deben hacer como root

#Paquetes Huerfanos
read -p '(2/4) ¿Desinstalar paquetes huérfanos? (S/N): ' TEXTO2
if [ "${TEXTO2,,}" = "s" ]; then
pacman -Rns $(pacman -Qtdq)
else
echo Omitido…
fi

#Borrado de todos los logs
read -p '(3/4) ¿Desea borrar todos los archivos de /var/log/? (S/N)' TEXTO3

if [ "${TEXTO3,,}" = "s" ]; then
echo Borrando todos los archivos de /var/log/
rm -r /var/log/*
else
echo Omitido…
fi

#Borrado de papelera ROOT
read -p '(4/4) ¿Desea borrar la papelera de reciclaje del usuario ROOT? (S/N)' TEXTO4
if [ "${TEXTO4,,}" = "s" ]; then
echo Borrando todos los archivos de /root/.local/share/Trash
rm -r /root/.local/share/Trash/*
else
echo Omitido…
fi

#Limpieza de Caché
read -p '(1/4) ¿Limpiar Caché de Pacman?(S/N):' TEXTO1
if [ "${TEXTO1,,}" = "s" ]; then
pacman -Scc
else
echo Omitido…
fi

#Obtener el espacio ocupado después de la limpieza
# efinal=$(du -b -s / | cut -f1)
# total=$(expr $einicial - $efinal )
# clear
#Convertir Bytes en MB

# totalmb=$(expr $total / 1048576)
echo '¡FINALIZADO!'  #' Se liberaron ' $totalmb ' MB después de la limpieza'

else
#Salida de la prueba de root
echo 'Es necesario ejecutar este programa como ROOT'
exit 1
fi
