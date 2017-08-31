#!/bin/bash
name=`ls /tmp |grep deviceAdbReport`
slave=`ls /tmp |grep deviceAdbReport|awk -F "_" '{print $2}'`
total=`cat "$name"| sed '1d' | cat -n | awk 'END {print($1)}'`
#model=`cat "$name"| awk -F "," '{print ($5)}'`
#echo "Total Connected Devices: $total"
#echo "$name"
#echo "$total"
for((i=1; i<=$total; i++)) 
#	sn=`cat "$name" | awk -v l=$i 'NR==l {print}'`
do
	adblist=`cat "$name" | sed '1d' | awk -v l=$i 'NR==l {print}'`
	key=`cat "$name" | sed '1d' | awk -v l=$i 'NR==l {print}'| awk -F "," '{print $1}'`
	model=`cat "$name" | sed '1d' | awk -v l=$i 'NR==l {print}'| awk -F "," '{print $2}'`
	modelelse=`cat "$name" | sed '1d' | awk -v l=$i 'NR==l {print}'| awk -F "," '{print $3}'`
	sn=`cat "$name" | sed '1d' | awk -v l=$i 'NR==l {print}'| awk -F "," '{print $5}'`
#	echo "$sn"
	if(("$sn" >= 20));
	then 
	 echo "$slave,$key,$model,$modelelse,$sn"
#	else
#	echo "good"
	fi

done
wait
	rm -rf $name
