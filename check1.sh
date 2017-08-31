#!/bin/bash
#source /etc/profile
DATE=$(date)
echo ----------$DATE--------------------------------------------------------------------------------------------
cache=`docker logs $(docker ps |grep cache|awk '{print$1}') --tail 1000|awk -F "[ ]" '{print$9}'|grep 200|wc -l`
#rsp="200"
echo "response $cache"
#rst=$(echo $cache |grep "$rsp")
if [ $cache -ge 800 ]
then
        echo "cache status is ok"
#	`echo -e "****************\n104 cache health\n****************"| mailx -v -s "cache" xxx@xxx.com`
else
        echo "cache error"
	`docker restart $(docker ps |grep cache|awk '{print$1}')`
	`echo -e "****************\n120cache 502\nrestarted cache now\n****************"| mailx -v -s "120cache" xxx@xxx.com`
#	`echo -e "****************\n120cache 502\nrestarted cache now\n****************"| mailx -v -s "120cache" xxx@xxx.com`
fi
#slave=`hostname`
#`echo "$slave dt-fileserver " >> ping.log`
#`date >> ping.log`
#`echo "$slave quail-fileserver " >> ping2.log`
#`date >> ping2.log`
#`docker exec -it $(docker ps |grep web-dt|awk '{print$1}') ping fileserver.web -c 2 >> ping.log`
b=`docker exec -i $(docker ps |grep web-dt|awk '{print$1}') ping fileserver.web -c 2 |tail -n 1|awk '{print$1}'`
a="round-trip"
#b=`tail -n 1 ping.log |awk '{print$1}'`
echo "dt $b"
result=$(echo $b |grep "$a")

c=`docker exec -i $(docker ps |grep web-quail|awk '{print$1}') ping fileserver.web -c 2 |tail -n 1|awk '{print$1}'`
#c=`tail -n 1 ping2.log |awk '{print$1}'`
result2=$(echo $c |grep "$a")
echo "quail $c"
if [[ "$result" != "" ]]
then
        echo "fileserver status is ok"
else
	if [[ "$result2" != "" ]]
		then
			echo "quail-connent ok"
		else
			echo "file quail-connect error"
			`echo filserver | mail -v -s "104fileserver--quail&&dt error" xxx@xxx.com`
	fi
fi
#	`rm ping.log ping2.log`
echo --------------------------------------------------------------------------------------------------------------
