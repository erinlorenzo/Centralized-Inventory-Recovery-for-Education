
# Configuración y Uso de Samba

## 📚 Introducción

El archivo principal de configuración de Samba es `/etc/samba/smb.conf`. A continuación se detallan las configuraciones que hemos añadido para permitir el acceso de cada usuario a su carpeta personal.

## ⚙️ Configuración de `/etc/samba/smb.conf`

```ini
[global]
   security = user
   map to guest = bad user

[homes]
   comment = Home Directories
   browseable = no
   read only = no
   create mask = 0700
   directory mask = 0700
   valid users = %S
   path = /home/samba/%S
```

**Explicación de la configuración:**

- `[global]`: Configuraciones globales del servidor Samba.
  - `security = user`: Requiere usuario y contraseña para acceder a los recursos.
  - `map to guest = bad user`: Redirige intentos fallidos de inicio de sesión al usuario invitado.

- `[homes]`: Configuración de las carpetas personales de cada usuario.
  - `comment`: Comentario visible en clientes.
  - `browseable = no`: No aparecen en explorador de red.
  - `read only = no`: Permite lectura y escritura.
  - `create mask` y `directory mask`: Permisos predeterminados para archivos y carpetas.
  - `valid users = %S`: Solo el propietario accede a su carpeta.
  - `path`: Carpeta física en el servidor para cada usuario.

## 📝 Script para crear usuarios y sus carpetas

**[Acceso al script](scripts/createUser.sh)**

El script `createUser.sh` crea un nuevo usuario, su carpeta personal en Samba y le asigna permisos y contraseña.

```bash
#!/bin/bash

# Recibe el nombre de usuario como argumento
username=$1

# Crea el usuario
sudo useradd $username

# Crea la carpeta personal y asigna permisos
sudo mkdir -p /home/samba/$username
sudo chown $username:$username /home/samba/$username
sudo chmod 700 /home/samba/$username

# Establece la contraseña del usuario
sudo smbpasswd -a $username
```

**Uso:**  
```bash
./createUser.sh nuevoUsuario
```
---
