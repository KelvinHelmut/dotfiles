#!/bin/sh
# mantener abierto el conky

while true
do
    echo "iniciando conky de compiz"
    conky -c $HOME/.aek6/compiz/conky/conky
done
