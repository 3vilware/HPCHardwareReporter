#!/bin/bash 

print_cabecera= echo "Usuario & Terminal & Ip & DiaS & Mes & DiaMes & HoraAcceso & Linea & HoraSale & Duracion" > pgfplotstable.example1.dat

last_1= last | grep "still logged in" | awk '{ print $1, "& " $2, "& " $3, "& " $4, "& " $5, "& " $6, "& " $7, "& " $8, $9, $10, "& &", "& " }' >> actividad.dat

#last_2= last -n 40 | grep "tty" | awk '{ print $1, "& " $2, "& - & " $3, "& " $4, "& " $5, "& " $6, "& " $7, "& " $8, "& " $9, $10}' >> actividad.dat

#last_3= last -n 40 | grep "pts" | grep "(" | awk '{ print $1, "& " $2, "& " $3, "& " $4, "& " $5, "& " $6, "& " $7, "& " $8, "& " $9, "& " $10}' >> actividad.dat

#last_4= last -n 40 | grep "system boot" | awk '{ print $1, "& " $2, $3, "& & " $4, "& " $5, "& " $6, "& " $7, "& " $8, "& " $9, "& " $10}' >> actividad.dat

status_node= pbsnodes -l > status.node.dat

$print_cabecera
$last_2
#$last_3
#$last_4
#$last_1
$status_node

pdflatex -interaction nonstopmode tabla_1.tex
