#!/bin/bash

month=$(date "+%m")

if [ $month -eq 01 ];then 
	echo "Mes|Dia --- Horas" > uso_dia.txt;
	ac -d | awk '{print $1" "$2"\t"$4" horas"}' | sed 's/Jan/Enero/g'|
	sed '/Today/d' >> uso_dia.txt;
elif [ $month -eq 02 ];then
	ac -d | awk '{print $1" "$2"\t"$4" horas"}' | sed 's/Feb/Febrero/g'|
	sed '/Today/d' >> uso_dia.txt;
elif [ $month -eq 03 ];then
	ac -d | awk '{print $1" "$2"\t"$4" horas"}' | sed 's/Mar/Marzo/g'|
	sed '/Today/d' >> uso_dia.txt;
elif [ $month -eq 04 ];then
	ac -d | awk '{print $1" "$2"\t"$4" horas"}' | sed 's/Apr/Abril/g'|
	sed '/Today/d' >> uso_dia.txt;
elif [ $month -eq 05 ];then
	ac -d | awk '{print $1" "$2"\t"$4" horas"}' | sed 's/May/Mayo/g'|
	sed '/Today/d' >> uso_dia.txt;
elif [ $month -eq 06 ];then
	ac -d | awk '{print $1" "$2"\t"$4" horas"}' | sed 's/Jun/Junio/g'|
	sed '/Today/d' >> uso_dia.txt;
elif [ $month -eq 07 ];then
	ac -d | awk '{print $1" "$2"\t"$4" horas"}' | sed 's/Jul/Julio/g'|
	sed '/Today/d' >> uso_dia.txt;
elif [ $month -eq 08 ];then
	ac -d | awk '{print $1" "$2"\t"$4" horas"}' | sed 's/Aug/Agosto/g'|
	sed '/Today/d' >> uso_dia.txt;
elif [ $month -eq 09 ];then
	ac -d | awk '{print $1" "$2"\t"$4" horas"}' | sed 's/Sep/Septiembre/g'|
	sed '/Today/d' >> uso_dia.txt;
elif [ $month -eq 10 ];then
	ac -d | awk '{print $1" "$2"\t"$4" horas"}' | sed 's/Oct/Octubre/g'|
	sed '/Today/d' >> uso_dia.txt;
elif [ $month -eq 11 ];then
	ac -d | awk '{print $1" "$2"\t"$4" horas"}' | sed 's/Nov/Noviembre/g'|
	sed '/Today/d' >> uso_dia.txt;
elif [ $month -eq 12 ];then
	ac -d | awk '{print $1" "$2"\t"$4" horas"}' | sed 's/Dec/Diciembre/g'|
	sed '/Today/d' >> uso_dia.txt;
fi

