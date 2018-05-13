#!/bin/bash
echo "USUARIO           HORAS" > actividad_horas.txt
ac -p | awk '{print $1"\t-----\t"$2}' |awk '{if(length($1)<8)print}' >> actividad_horas.txt

