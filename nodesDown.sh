#!/bin/bash

	pbsnodes -l | awk '{print $1,$2}' | sed 's/node/Nodo /g' | sed 's/down/Apagado/g' >> nodesDown.txt
