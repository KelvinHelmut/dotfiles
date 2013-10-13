#!/usr/bin/sh
#
# Captura usando import
# captura de una area seleccionada
# para ver el resultado uso gpicview
#
_captura=Captura-$(date +%Y-%m-%d-%T)
import ~/Imágenes/Capturas/$_captura.png
gpicview ~/Imágenes/Capturas/$_captura.png
