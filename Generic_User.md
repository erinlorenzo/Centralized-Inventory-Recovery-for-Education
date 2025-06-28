
# Configuración de Usuarios Genéricos en Clientes Ubuntu

## 📚 Introducción

En cada cliente Ubuntu configuramos un usuario administrador con permisos de superusuario y un usuario genérico sin permisos, cuya home está congelada para garantizar un entorno limpio en cada inicio. Además, se automatiza la conexión al servidor Samba y OCS, y se configuran accesos directos para login/logout en Samba.

## ⚙️ Configuraciones Generales

### Login Automático del Usuario Genérico

En `/etc/gdm3/custom.conf`:

```ini
[daemon]
# Enabling timed login
TimedLoginEnable = true
TimedLogin = usuarioGenerico
TimedLoginDelay = 7
```

Así, tras 7 segundos sin interacción, el sistema inicia sesión automáticamente en el usuario genérico.

## 🗄️ Acceso a Recursos de Samba

Se configuran scripts de `loginSMB.sh` y `logoutSMB.sh` para conectar y desconectar recursos Samba mediante accesos directos en el escritorio.

**[Acceso al script de login](scripts/loginSMB.sh)**

**[Acceso al script de logout](scripts/loginSMB.sh)**

Además, configuramos permisos en `/etc/sudoers` para permitir al usuario genérico montar y desmontar solo las carpetas Samba en `/mnt` sin contraseña:

```ini
usuarioGenerico ALL=(ALL) NOPASSWD: /bin/mount -t cifs //ip-server/* /mnt -o username=*password=*
usuarioGenerico ALL=(ALL) NOPASSWD: /bin/umount /mnt
```
**Nota**: cambiar ip-server por la dirección del servidor.

## 🗃️ Congelar la Home del Usuario Genérico

**[Acceso al script](scripts/resetHome.sh)**

El script `resetHome.sh` borra y reemplaza la home del usuario genérico con una copia limpia, aplica permisos y desmonta posibles carpetas de Samba montadas:

```bash
#!/bin/bash

rm -rf /home/usuarioGenerico/
cp -r /usr/local/bin/resetHome/usuarioGenerico/ /home

chown usuarioGenerico:usuarioGenerico -R /home/usuarioGenerico
chmod 755 -R /home/usuarioGenerico
chmod 750 /home/usuarioGenerico

umount /mnt
```

Este script se ejecuta en cada reinicio desde el crontab de root:

```
@reboot /usr/local/bin/resetHome/resetHome.sh
```

---

