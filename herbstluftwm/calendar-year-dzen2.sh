#!/bin/bash

hc() { "${herbstclient_command[@]:-herbstclient}" "$@" ;}
monitor=${1:-0}
geometry=( $(herbstclient monitor_rect "$monitor") )
if [ -z "$geometry" ] ;then
    echo "Invalid monitor $monitor"
    exit 1
fi
# geometry has the format W H X Y
width_monitor=${geometry[2]}
width=650
x=$[$width_monitor / 2 - $width / 2]

(
echo ""
cal -y --color=always | sed -e's/^/   /' \
    -e's/..[0-9][0-9]*m[0-9][0-9]*..[0-9][0-9]*m/^fg(#FF0000)&^fg(#FFFFFF)/' \
    -e 's/..[0-9][0-9]*m//g'
) | dzen2 -p -x "$x" -y "30" -w "$width" -l "35" -sa 'l' -ta 'c'\
    -title-name 'popup_calendar' -e 'onstart=uncollapse;button1=exit;button3=exit'
