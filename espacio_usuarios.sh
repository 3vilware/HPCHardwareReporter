#!/bin/bash

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
