#!/bin/bash
log=`docker logs $(docker ps -a|grep adb|awk '{print$1}')|tail -n 1`
#echo "adb status is:$log"
a="OK"
b=`ps aux|grep 5037|grep root|awk '{print$2}'`
#echo "adb PID is:"
#echo $b
result=$(echo $log |grep "$a")
if [[ "$result" != "" ]]
then
#	echo "adb status is ok"
	echo " "
else
#	echo "kill adb...."
#	`docker stop $(docker ps|grep testcenter|awk '{print$1}')`
	`sudo kill -9 $b`
#	`docker start $(docker ps | grep adb |awk '{print$1}')`
#	`docker start $(docker ps|grep testcenter|awk '{print$1}')`
	echo "adb restart successd"
fi
