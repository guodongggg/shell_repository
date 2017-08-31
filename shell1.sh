#!/bin/sh
#read -p "INTER YOUR ADB SHELL" -s pwd
#echo

total=`adb devices | sed '1d;$d' | cat -n | awk 'END {print($1)}'`
devices_list=`adb devices | sed '1d;$d' | awk '{$NF="";print}'`

echo "Total Connected Devices: $total"
for((i=1; i<=$total; i++))
do
    sn=`adb devices | sed '1d;$d' | awk '{$NF="";print}' | awk -v l=$i 'NR==l {print}' | sed -e 's/[ ]*$//g'`
    echo "CMD for $sn"
    adb -s "$sn" "$1" "$2" "$3" &
done
wait

echo "$1" "$2" "$3"
