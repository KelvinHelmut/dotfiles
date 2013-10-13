#!/bin/bash
#
# Mostrar captura de pantalla al bloquear
#
file1=$(mktemp --tmpdir i3lock-XXXXXXXXXX.png)
file2=$(mktemp --tmpdir i3lock-XXXXXXXXXX.png)

imlib2_grab "$file1"
convert "$file1" -blur 0x3 "$file2"
i3lock -i "$file2"
rm "$file1" "$file2"
