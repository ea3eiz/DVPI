#!/bin/bash
while true
do
clear


# path usuario
usuario=$(awk "NR==1" /home/pi/.config/autostart/usuario)
SCRIPTS_version=$(awk "NR==1" $usuario/.config/autostart/version)
#Editor DMRGateway Brabdmeister
DIRECTORIO="DVPi"

#Colores
ROJO="\033[1;31m"
VERDE="\033[1;32m"
BLANCO="\033[1;37m"
AMARILLO="\033[1;33m"
CIAN="\033[1;36m"
GRIS="\033[0m"
MARRON="\33[38;5;138m"
echo "${VERDE}"
echo "  ***************************************************************************"
echo "                  Script Modificar $DIRECTORIO             \33[1;31m by EA3EIZ\33[1;32m   "
echo "  ***************************************************************************"

echo -n "${CIAN}   1)${GRIS} Modificar Indicativo  - ${AMARILLO}"
indicativo=$(awk "NR==2" /opt/MMDVM_Bridge/MMDVM_Bridge.ini)
echo "$indicativo"

echo -n "${CIAN}   2)${GRIS} Modificar Id          - ${AMARILLO}"
id=$(awk "NR==3" /opt/MMDVM_Bridge/MMDVM_Bridge.ini)
echo "$id"

echo -n "${CIAN}   3)${GRIS} Modificar Location    - ${AMARILLO}"
contenido_location=$(awk "NR==14" /opt/MMDVM_Bridge/MMDVM_Bridge.ini)
echo "$contenido_location"

echo -n "${CIAN}   4)${GRIS} Modificar URL         - ${AMARILLO}"
contenido_url=$(awk "NR==16" /opt/MMDVM_Bridge/MMDVM_Bridge.ini)
echo "$contenido_url"


echo -n "${CIAN}   5)${GRIS} Modificar Address     - ${AMARILLO}"
address_BM=$(awk "NR==70" /opt/MMDVM_Bridge/MMDVM_Bridge.ini)
echo "$address_BM"

echo -n "${CIAN}   6)${GRIS} Modificar Password    - ${AMARILLO}"
pas_BM=$(awk "NR==71" /opt/MMDVM_Bridge/MMDVM_Bridge.ini)
echo "$pas_BM"

echo -n "${CIAN}   7)${GRIS} Modificar Options     - ${AMARILLO}"
options_BM=$(awk "NR==77" /opt/MMDVM_Bridge/MMDVM_Bridge.ini)
echo "$options_BM"


echo ""
echo "${CIAN}   0)\33[1;31m Salir"
echo ""
echo -n "${CIAN}   Elije una opción: " 
read escoger_menu
case $escoger_menu in
1) echo ""
while true
do
                          echo "   Valor  actual  del Indicativo: ${AMARILLO}${indicativo#*=}\33[1;37m"
                          read -p '   Introduce el Indicativo ' indicativo
                          actualizar=S 
                          case $actualizar in
                          [sS]* ) echo ""
                          indicativo=`echo "$indicativo" | tr [:lower:] [:upper:]`
                          sed -i "2c Callsign=$indicativo" /opt/MMDVM_Bridge/MMDVM_Bridge.ini
                          break;;
                          [nN]* ) echo ""
                          break;;
esac
done;;
2) echo ""
while true
do
                          echo "   Valor  actual  de la Id: ${AMARILLO}${id#*=}\33[1;37m"
                          read -p '   Introduce la Id ' id
                          actualizar=S 
                          case $actualizar in
                          [sS]* ) echo ""
                          sed -i "3c Id=$id" /opt/MMDVM_Bridge/MMDVM_Bridge.ini
                          break;;
                          [nN]* ) echo ""
                          break;;
esac
done;;
3) echo ""
while true
do
                          echo "Valor de la Ciudad: ${AMARILLO}${contenido_location#*=}\33[1;37m"
                          read -p 'Introduce tu Ciudad ' loc1
                          actualizar=S 
                          case $actualizar in
			                    [sS]* ) echo ""
                          sed -i "14c Location=$loc1" /opt/MMDVM_Bridge/MMDVM_Bridge.ini
			                    break;;
			                    [nN]* ) echo ""
			                    break;;
esac
done;;
4) echo ""
while true
do
                          echo "   Valor de  la  URL   Web: ${AMARILLO}${contenido_url#*=}\33[1;37m"
           	              read -p '   Introduce URL de tu Web: ' ur1
                          actualizar=S 
                          case $actualizar in
			                    [sS]* ) echo ""
			                    ur1=`echo "$ur1" | tr -d '[[:space:]]'`
                          sed -i "16c URL=$ur1" /opt/MMDVM_Bridge/MMDVM_Bridge.ini
			                    break;;
			                    [nN]* ) echo ""
			                    break;;
esac
done;;
5) echo ""
while true
do
                      echo "   Valor actual del Master: ${AMARILLO}${address_BM#*=}\33[1;37m"
                      read -p '   Brandmeister Spain = master.spain-dmr.es: ' master
                      actualizar=S 
                      case $actualizar in
                      [sS]* ) echo ""
                      master=`echo "$master" | tr -d '[[:space:]]'`
                      master=`echo "$master" | tr [:upper:] [:lower:]`
                      sed -i "70c Address=$master" /opt/MMDVM_Bridge/MMDVM_Bridge.ini
                      break;;
                      [nN]* ) echo ""
                      break;;
esac
done;;
6) echo ""
while true
do
                      echo "   Valor actual del Password: ${AMARILLO}${pas_BM#*=}\33[1;37m"
                      read -p '   Introduce Password Personal de Brandmeister = ' pasbm
                      actualizar=S 
                      case $actualizar in
                      [sS]* ) echo ""
                      sed -i "71c Password=$pasbm" /opt/MMDVM_Bridge/MMDVM_Bridge.ini
                      break;;
                      [nN]* ) echo ""
                      break;;
esac
done;;
7) echo ""
while true
do
                          read -p 'Estas en DMR+ ? S/N ' actualizar                                          
                          case $actualizar in
                          [sS]* ) echo ""
                          read -p 'Intruduce reflector DMR+ al que se conectara (ej:4370) ' options
                          if [ $options = 21465 ]
                          then
                          sed -i "77c Options=StartRef=4000;RelinkTime=15;TS2_1=21465" /opt/MMDVM_Bridge/MMDVM_Bridge.ini
                          else
                          sed -i "77c Options=StartRef=$options;RelinkTime=10;" /opt/MMDVM_Bridge/MMDVM_Bridge.ini
                          fi
                          break;;
                          [nN]* ) echo ""
                          sed -i "77c #Options=StartRef=4370;RelinkTime=10;" /opt/MMDVM_Bridge/MMDVM_Bridge.ini
                          break;;
esac
done;;
0) echo ""
clear
exit;;	
esac
done