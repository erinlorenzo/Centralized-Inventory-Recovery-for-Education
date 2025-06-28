
# Instalación de GLPI en Ubuntu

## 📚 Requisitos previos

- Apache
- MariaDB
- PHP y extensiones necesarias

## 🔥 Instalación de Apache y MariaDB

```
sudo apt-get install apache2
sudo apt-get install mariadb-server
mysql_secure_installation
```

## 📦 Instalación de PHP

```
sudo apt install php libapache2-mod-php
sudo apt install php8.1-{mysql,xml,curl,gd,intl,ldap,bz2,zip,mbstring} php-cas
```

## 📥 Descarga e instalación de GLPI

```
wget https://github.com/glpi-project/glpi/releases/download/10.0.x/glpi-10.0.x.tgz
tar -xzf glpi-10.0.x.tgz
sudo mv glpi/ /var/www/html/
sudo chown -R www-data:www-data /var/www/html/glpi
```

## 🗄️ Creación de base de datos

```
sudo mysql -u root -p
CREATE DATABASE glpi;
quit
```

## 🌐 Asistente de instalación

Accede a `http://ip-servidor/glpi` y sigue los pasos para completar la instalación, usando:

- SQL server: IP o dominio del servidor
- Usuario SQL: root
- Contraseña: contraseña root de mariaDB

## 👤 Usuarios y contraseñas predeterminados de GLPI

| User | Password |
|-------|----------|
| glpi | glpi |
| tech | tech |
| normal | normal |
| post-only | postonly |


## 🔒 Post-instalación

- Cambiar contraseñas de usuarios predeterminados.
- Borrar `install/install.php`:

```
sudo rm /var/www/html/glpi/install/install.php
```

## ⚙️ Configuración de Apache y PHP

Editar `/etc/apache2/sites-available/000-default.conf` y establecer:

```
DocumentRoot /var/www/html/glpi

<Directory /var/www/html/glpi/public>
    Require all granted
    RewriteEngine On
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^(.*)$ index.php [QSA,L]
</Directory>
```

Activar módulo rewrite y reiniciar Apache:

```
sudo a2enmod rewrite
sudo systemctl restart apache2
```

## 📝 Cambios en php.ini

En `session.cookie_httponly` establecer `on`:

```
session.cookie_httponly = on
```

## ⚠️ Solución de advertencia adicional

Timezone:

```
sudo mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -p -u root mysql
```

---
