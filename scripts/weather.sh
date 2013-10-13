#!/usr/bin/sh
#AccuWeather (r) RSS weather tool for conky
#
#USAGE: weather.sh <locationcode>
#

METRIC=1 #Deberia ser 0 o 1; 0 para F, 1 para C

if [ -z $1 ]; then
    echo
    echo "USAGE: weather.sh <locationcode>"
    echo
    exit 0;
fi

curl -s http://rss.accuweather.com/rss/liveweather_rss.asp\?metric\=${METRIC}\&locCode\=$1 | perl -ne 'if (/Currently/) {chomp;/\<title\>Currently: (.*)?\<\/title\>/; print "$1"; }'
