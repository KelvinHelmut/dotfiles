#!/bin/bash 

shopt -s nullglob
cd ~/Imágenes/Fondos

while true; do
    files=()
    for i in *.jpg *.png; do
        [[ -f $i  ]] && files+=("$i")
    done
    range=${#files[@]}

    ((range)) && feh --bg-fill "${files[RANDOM % range]}"

    `$HOME/.aek6/scripts/imagebgconky`
    sleep 5m
done
