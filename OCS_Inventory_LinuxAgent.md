
# Instalación y Configuración del Agente de OCS Inventory

## 📚 Introducción

Hemos automatizado la instalación y configuración del agente de OCS Inventory mediante un script (`ocsAgent.sh`). Este script se encarga de instalar el agente, configurar el nombre del host tomando la dirección MAC del dispositivo, y asignar un nombre de grupo para que sea más visual y organizado dentro de OCS. Además, configuramos el agente para ejecutarse de forma regular gracias a `crontab`, manteniendo así la información del inventario siempre actualizada.

## 📥 Obtención del paquete del Agente

Descargar la versión del paquete del agente desde la [página oficial de OCS Inventory](https://github.com/OCSInventory-NG/UnixAgent/releases). Por ejemplo:

```
wget https://github.com/OCSInventory-NG/UnixAgent/releases/download/2.10.2/Ocsinventory-Unix-Agent-2.10.2.tar.gz
```

Descomprimir el paquete:

```
tar -xzvf Ocsinventory-Unix-Agent-2.10.2.tar.gz
```

**Nota**: En nuestro caso, ya dejamos el paquete del agente descomprimido dentro de las imágenes base que generamos y desplegamos con FOG. Así, solo es necesario ejecutar el script ocsAgent.sh en cada equipo diferente para configurar correctamente el nombre del grupo y del host según corresponda.

## ⚙️ Script de instalación automatizada

En el repositorio incluimos un script llamado `ocsAgent.sh` dentro de la carpeta `scripts/`. Este script:

- Obtiene la dirección MAC de la interfaz de red principal del equipo
- Asigna un nombre de host único basado en la MAC (reemplazando los dos puntos por guiones)
- Añade un prefijo de grupo al hostname para organizar los equipos en OCS de forma más visual
- Instala y configura el agente, utilizando los parámetros necesarios para integrarlo con el servidor de OCS

**Acceso al script:** [scripts/ocsAgent.sh](scripts/ocsAgent.sh)

### Contenido del script

Ac

```bash
#!/bin/bash

# Obtener la dirección MAC de la interfaz de red
mac_address=$(ip link show enp0s3 | grep -o -E '([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}' | head -n 1)

# Construir hostname con nombre de grupo + MAC
hostname="nombreGrupo-${mac_address//:/-}"

# Cambiar nombre de host
sudo hostnamectl set-hostname $hostname

# Entrar en el directorio donde se encuentra el paquete del agente
cd /path/to/Ocsinventory-Unix-Agent-2.10.2 || exit

# Ejecutar instalación
sudo env PERL_AUTOINSTALL=1 perl Makefile.PL && sudo make && sudo make install && sudo perl postinst.pl --nowizard --server=http://ip-server/ocsinventory --configdir=/etc/ocsinventory-agent --basevardir=/var/lib/ocsinventory-agent --crontab --debug --logfile=/var/log/ocsinventory-agent.log --download --snmp --now --tag="$hostname"
```

## 🕒 Ejecución periódica

Gracias al parámetro `--crontab` durante el despliegue de la imagen, el agente se configura automáticamente y puedes configurarlo para ejecutarlo de forma regular desde el `cron`, manteniendo la información de inventario actualizada según nuestras preferencias en el servidor de OCS.

## ✅ Notas

- Cambiar `nombreGrupo` por el prefijo que desees usar para diferenciar equipos por grupo
- Sustituir `/path/to/` por la ruta donde se ha descomprimido el paquete del agente
- Reemplazar `ip-server` por la IP o dominio de tu servidor de OCS Inventory

---
