#!/bin/sh
# mantener abierto el conky-mpd

while true
do
    echo "iniciando conky-mpd compiz"
    conky -c $HOME/.aek6/compiz/conky/conky-mpd
done
