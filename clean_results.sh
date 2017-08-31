#!/usr/bin/env bash
container=`docker ps|grep adb|awk '{print $NF}'`
docker exec -it $container adb devices|while read line;
do
    device=`echo $line|awk '{print $1}'`
    if [ ${#device} = 32 ] || [ ${#device} = 36 ] ;then
        echo clean $device
        docker exec $container adb -s $device shell rm -rf /sdcard/testbird/quail
    fi
done