#!/bin/bash

# Copiar el contenido del origen al destino
rm -rf /home/usuarioGenerico/
cp -r /usr/local/bin/resetHome/usuarioGenerico/ /home

chown usuarioGenerico:usuarioGenerico -R /home/usuarioGenerico
chmod 755 -R /home/usuarioGenerico
chmod 750 /home/usuarioGenerico

umount /mnt
