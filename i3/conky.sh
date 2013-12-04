#!/bin/sh

# Send the header so that i3bar knows we want to use JSON:
echo '{ "version": 1 }'
echo '['
echo '[],'
exec conky -c $HOME/.aek6/i3/conky_bar
