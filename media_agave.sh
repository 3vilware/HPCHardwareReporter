#!/bin/bash 

inicio=0
uno=1

for k in {1..16..1}; do

        ping -c1 node$k > /dev/null

        if [ $? -eq 0 ]; then
                continue
        else
            	echo 0 > media$k.txt
		cat -n media$k.txt > datos$k.txt
        fi
done



for j in {1..16..1}; do

	ping -c1 node$j > /dev/null

	if [ $? -eq 0 ]; then
		let nodos+=$inicio+$uno
	else
		echo 0 > media$i.txt
	fi
done 


for i in {1..16..1}; do


		last=$(tail -1 datos$i.txt | awk '{print $1}')

		cat datos$i.txt | awk '{sum += $2} END {print sum/$last}' > media$i.txt
	if [ $i -eq 1 ]; then
		cat media$i.txt > media_aux.txt
	else
		cat media$i.txt >> media_aux.txt
	fi
	cat -n media_aux.txt > media_cluster.txt
	cat media_aux.txt | awk '{sum += $1} END {print sum/16}' > media_total.txt
	#resultado entre los recursos disponibles
done 


