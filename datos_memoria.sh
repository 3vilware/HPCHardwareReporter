#!/bin/bash
echo 0 > memoria_usando_nodos.txt

for i in {1..16..1}; do
	ping -c 1 node$i > /dev/null
		
	if [ $? -eq 0 ]; then
		cluster_exec -n node[$i] free -m | grep "Mem" |
		awk '{print $3}' >> memoria_total_nodos.txt

		cluster_exec -n node[$i] free -m | grep "Mem" |
                awk '{print $4}' >> memoria_usando_nodos.txt
	 else
	       continue  
	 fi

	done 
		echo 0 > memoria_uso.txt
		cat memoria_total_nodos.txt | awk '{ sum += $1 } END { print sum }' > memoria_total.txt
		cat memoria_usando_nodos.txt | awk '{ sum += $1 } END { print sum }' >> memoria_uso.txt
