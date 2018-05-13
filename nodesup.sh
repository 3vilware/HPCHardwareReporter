#!/bin/bash 

cluster_ping |sed 's/nodes/nodos/g' | sed 's/up/Activos/g' | sed 's/:/./g' | awk 'NR==2' > nodesup.txt

