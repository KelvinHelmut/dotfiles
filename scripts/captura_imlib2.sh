#!/usr/bin/sh
# captura de pantalla con imlib2_grab
#
# necesita de visor de imágenes gpicview o cambiar la linea por su visor de imágenes
# captura toda la pantalla
_captura=Captura-$(date +%Y-%m-%d-%T)
imlib2_grab ~/Imágenes/Capturas/$_captura.png
gpicview ~/Imágenes/Capturas/$_captura.png
