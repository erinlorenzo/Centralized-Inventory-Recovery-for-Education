#!/bin/bash

# Obtener la dirección MAC de la interfaz de red
mac_address=$(ip link show enp0s3 | grep -o -E '([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}' | head -n 1)

# Imprimir la dirección MAC
hostname="nombreGrupo-${mac_address//:/-}"

# Cambiar el nombre de host del equipo
sudo hostnamectl set-hostname $hostname

cd /path/to/Ocsinventory-Unix-Agent-2.10.2 ||exit

sudo env PERL_AUTOINSTALL=1 perl Makefile.PL && sudo make && sudo make install && sudo perl postinst.pl --nowizard --server=http://ip-server/ocsinventory --configdir=/etc/ocsinventory-agent --basevardir=/var/lib/ocsinventory-agent --crontab --debug --logfile=/var/log/ocsinventory-agent.log --download --snmp --now --tag="$hostname"
