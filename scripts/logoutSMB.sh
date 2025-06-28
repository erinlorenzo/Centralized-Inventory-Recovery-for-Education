#!/bin/bash

carpeta=$(find ~/Escritorio -type l)
usuario=$(basename "$carpeta")

# Mostrar diálogo emergente para confirmar acción
respuesta=$(zenity --question --title="Confirmación" --text="¿Quieres cerrar la sesión de la carpeta '$usuario?'")

# Verificar la respuesta del usuario
if [ $? -eq 0 ]; then
    # El usuario ha confirmado la acción

    # Desmontar la carpeta compartida
    sudo umount /mnt

    # Encontrar y eliminar el enlace simbólico en el escritorio
    rm $carpeta
else
    # El usuario ha cancelado la acción
    exit 0
fi
