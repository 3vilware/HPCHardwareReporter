#!/bin/bash
echo "Estatus de la memoria RAM por nodo" > memoria.txt
for i in {1..16..1}; do

	ping -c 1 node$i > /dev/null
	
	if [ $? -eq 0 ]; then	
	echo "Nodo $i"  >> memoria.txt
	cluster_exec -n node[$i] free -m | grep "Mem" | awk '{print "Total = "$3"MB\tUsada = "$4"MB"}' >> memoria.txt
	
	else
            	echo Nodo $i Apagado. >> memoria.txt
        fi
done

     
