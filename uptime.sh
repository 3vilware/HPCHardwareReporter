#!/bin/bash
echo "Tiempo de actividad de cada Nodo desde su ultimo apagado" > uptime.txt
for i in {1..16..1}; do
	
	ping -c 1 node$i > /dev/null
        
	if [ $? -eq 0 ]; then
		echo "Nodo $i"  >> uptime.txt
		cluster_exec -n node[$i] uptime | awk '{print $3,$4,$5}' | sed 's/up/Activo/g' | 
		sed 's/days/dias/g' | sed 's/,/./g' >> uptime.txt
	else
		echo Nodo $i Apagado. >> uptime.txt
	fi
done
