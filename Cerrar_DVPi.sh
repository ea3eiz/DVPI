#!/bin/bash
# path usuario
usuario=$(awk "NR==1" /home/pi/.config/autostart/usuario)
SCRIPTS_version=$(awk "NR==1" /home/pi/.config/autostart/version)

cd $usuario/Desktop
sudo cp Abrir_DVPi.desktop /home/pi
sed -i "4c Exec=sh -c 'cd /home/pi/$SCRIPTS_version; sudo sh Abrir_DVPi.sh'" $usuario/Abrir_DVPi.desktop
sed -i "5c Icon=/home/pi/$SCRIPTS_version/ICONO_DVPI_OFF.png" $usuario/Abrir_DVPi.desktop
sed -i "10c Name[es_ES]=Abrir DVPi" $usuario/Abrir_DVPi.desktop
sed -i "22c DVPi=OFF" $usuario/status.ini
cd $usuario
sudo cp Abrir_DVPi.desktop $usuario/Desktop
sleep 1
sudo rm $usuario/Abrir_DVPi.desktop

cd /home/pi/dvpi
sudo killall mono
