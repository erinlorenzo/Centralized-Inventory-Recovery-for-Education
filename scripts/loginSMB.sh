#!/bin/bash


# Mostrar diálogo emergente para ingresar nombre de usuario y contraseña
usuario=$(zenity --entry --title="Ingresar Usuario" --text="Por favor, ingrese su nombre de usuario:")
contrasena=$(zenity --password --title="Ingresar Contraseña" --text="Por favor, ingrese su contraseña para $usuario:")

if mountpoint -q /mnt; then
    folder=$(find ~/Escritorio -type l)
    user=$(basename "$folder")
    respuesta=$(zenity --question --title="Confirmación" --text="¿Se cerrará la sesión de la carpeta '$user'. Quieres continuar?")

    if [ $? -eq 0 ]; then
        # El usuario quiere continuar, desmontar la carpeta
        sudo umount /mnt
        # Eliminar el enlace simbólico en el escritorio
        rm "$folder"
    else
        # El usuario ha cancelado la acción, salir del script
        exit 0
    fi
fi


# Verificar si se ingresó un nombre de usuario y contraseña válidos
if [ -z "$usuario" ] || [ -z "$contrasena" ]; then
    zenity --error --text="¡Debe ingresar un nombre de usuario y una contraseña válidos!"
    exit 1
fi

# Intentar montar la carpeta compartida
if ! sudo mount -t cifs //ip-servidor/$usuario /mnt -o username=$usuario,password=$contrasena,rw,uid=$(id -u $USER),gid=$(id -g $USER); then
    zenity --error --text="¡No se pudo conectar a la carpeta compartida del servidor!" 
    exit 1
fi

ln -s /mnt ~/Escritorio/$usuario

# Mostrar mensaje de conexión exitosa
zenity --info --title="Conexión Exitosa" --text="¡Conexión exitosa a la carpeta compartida del servidor!"
