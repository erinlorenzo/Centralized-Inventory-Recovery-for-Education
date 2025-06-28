#!/bin/bash

# Recibe el nombre de usuario como argumento
username=$1

# Crea el usuario
sudo useradd $username

# Crea la carpeta personal del usuario y le asigna los permisos
sudo mkdir -p /home/samba/$username
sudo chown $username:$username /home/samba/$username
sudo chmod 700 /home/samba/$username

# Establece la contraseña del usuario
sudo smbpasswd -a $username
