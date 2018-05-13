#!/bin/bash

#
#
#
#
#

num_nodos=16

function activiad_horas()
{
	echo "USUARIO           HORAS" > actividad_horas.txt
	ac -p | awk '{print $1"\t-----\t"$2}' |awk '{if(length($1)<8)print}' >> actividad_horas.txt

}

function almacenamiento_usuarios()
{
	#NOTA: modificar la ruta de ejecucion segun directorio final
	cd && cd ..;
	cd /home;
	echo " Espacio --- Usuario" > /home/admin2/Informe/reporte/espacio_usuarios.txt
	echo "----------|--------------------" >> /home/admin2/Informe/reporte/espacio_usuarios.txt
	du -sh */ | sed 's/[/]/ /g' | awk '{print $1"\t\t"$2}' | 
	sed 's/K/ KB/g'| sed 'a----------|--------------------' >> /home/admin2/Informe/reporte/espacio_usuarios.txt;
	cd ..;
	space=$(du -sh /home | awk '{print $1}' | sed 's/G/ GB/g')
	echo "ESPACIO TOTAL OCUPADO POR LOS USUARIOS  $space" >> /home/admin2/Informe/reporte/espacio_usuarios.txt

}

function memoria()
{
	echo "Estatus de la memoria RAM por nodo" > memoria.txt
		for i in {1..16..1}; do

			ping -c 1 node$i > /dev/null
			
			if [ $? -eq 0 ]; then	
			echo "Nodo $i"  >> memoria.txt
			cluster_exec -n node[$i] free -m | grep "Mem" |
			 awk '{print "Total = "$3"MB\tUsada = "$4"MB"}' >> memoria.txt
			
			else
		            	echo Nodo $i Apagado. >> memoria.txt
		        fi
		done

}

function nodesDown()}
{
		pbsnodes -l | awk '{print $1,$2}' | sed 's/node/Nodo /g' | 
		sed 's/down/Apagado/g' >> nodesDown.txt

}

function nodesUP()
{
	cluster_ping |sed 's/nodes/nodos/g' | sed 's/up/Activos/g' | 
	sed 's/:/./g' | awk 'NR==2' > nodesup.txt

}

function uptime_nodos()
{	
for i in {1..16..1}; do
	
	ping -c 1 node$i > /dev/null
        
	if [ $? -eq 0 ]; then
		echo "Nodo $i"  >> uptime.txt
		cluster_exec -n node[$i] uptime | awk '{print $3,$4,$5}' |
		 sed 's/up/Activo/g' | 
		sed 's/days/dias/g' | sed 's/,/./g' >> uptime.txt
	else
		echo Nodo $i Apagado. >> uptime.txt
	fi
done

}

function uso_dia()
{

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

}


function graficos()
{
	#Recoleccion por dia 1440/1min > media_day$i.txt
	#Recoleccion semanal dias_media/7 > semana$i.txt
	#Recoleccion mensual semanas_media/4 > mes.txt

	num_datos=60

	for i in {1..5..1}; do

	        ping -c 1 node$i > /dev/null
	        if [ $? -eq 0 ]; then
	                cluster_exec -n node[$i] sar -u 1 $num_datos | awk '{print $5}'| 
	                sed '1,3 d' | sed -n '1,60 p' > aux$i.txt &
	 

	        else
	            	continue  
	        fi
	done

	wait


	for j in {1..5..1}; do

			cat -n aux$i.txt > datos$i.txt 
	        cat test$j | gnuplot > grafico$j.jpg

	done

	###FALTA GRAFICO DE MEMORIA (meter 1 solo grafico)
	###FALTA GRAFICO DE BARRA DE TODO EL CLUSTER POR MEDIA
}

function grafico_memoria()
{
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



}

function uso_agave()
{

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

}



backup
{
	#!/bin/bash
	num_datos=60

	i=1
	for i in {1..5..1}; do

	        ping -c 1 node$i > /dev/null
	        if [ $? -eq 0 ]; then
	                cluster_exec -n node[$i] sar -u 1 $num_datos | awk '{print $5}'| 
	                sed '1,3 d' | sed -n '1,60 p' > aux$i.txt &
	        else
	            echo "Nodo $i Apagado"
	        fi
	done

	wait

	j=1

	for j in {1..5..1}; do

	        cat -n aux$j.txt > datos$j.txt
	        cat test$j | gnuplot > grafico$j.jpg

	done

}


actividad_horas
almacenamiento_usuarios
memoria
nodesDown
nodesUP
uptime_nodos
uso_dia

