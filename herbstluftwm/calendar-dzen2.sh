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
width=240
x=$[$width_monitor - $width - 1]

(
echo ""
dia=`date +%d`; cal | sed -e's/^/   /' -e's/'$dia'/^fg(#FF0000)&^fg(#FFFFFF)/'
echo "                       " \
     "^ca(1,$HOME/.aek6/herbstluftwm/calendar-year-dzen2.sh)^fg(#00FFFF)+^ca()"
echo ""
) | dzen2 -p -x "$x" -y "19" -w "$width" -l "10" -sa 'l' -ta 'c' -title-name \
    'popup_calendar' -e 'onstart=uncollapse;button1=exit;button3=exit'
