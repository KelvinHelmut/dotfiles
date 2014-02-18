#!/bin/sh

show() { echo -n "hola mundo"; }

hc() { "${herbstclient_command[@]:-herbstclient}" "$@" ;}
monitor=${1:-0}
geometry=( $(herbstclient monitor_rect "$monitor") )
if [ -z "$geometry" ] ;then
    echo "Invalid monitor $monitor"
    exit 1
fi
# geometry has the format W H X Y
x=${geometry[0]}
y=${geometry[1]}
panel_width=${geometry[2]}
panel_width=$[$panel_width / 2 + 100]
x=$[$panel_width - 200]
panel_height=18
font="-*-fixed-medium-*-*-*-12-*-*-*-*-*-*-*"
bgcolor=$(hc get frame_border_normal_color)
selbg=$(hc get window_border_active_color)
selfg='#101010'

{
    conky -c $HOME/.aek6/herbstluftwm/conky
} 2> /dev/null | dzen2 -w $panel_width -x $x -y $y \
    -fn "$font" -h $panel_height -ta r -bg "$bgcolor" -fg '#efefef'
