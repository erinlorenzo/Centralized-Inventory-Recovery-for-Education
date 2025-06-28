
# Instalación de OCS Inventory NG en Ubuntu

## 📚 Requisitos previos

- Apache instalado (recomendado tenerlo por la instalación de GLPI)
- MariaDB
- PHP y extensiones necesarias
- Paquetes y módulos Perl necesarios

## 🔥 Instalación de paquetes necesarios

Instalar paquetes Perl y herramientas de compilación:

```
sudo apt -y install libxml-simple-perl libdbi-perl libdbd-mysql-perl libapache-dbi-perl libnet-ip-perl libsoap-lite-perl libarchive-zip-perl make build-essential libio-compress-perl 
```

Instalar módulos de Perl:

```
cpan install XML::Entities
perl -MCPAN -e 'install Mojolicious' 
perl -MCPAN -e 'install Switch' 
perl -MCPAN -e 'install Plack::Handler' 
```

## 📦 Instalación de Apache, PHP y librerías

Instalar Apache (si no está instalado) y módulos necesarios:

```
sudo apt-get install apache2 libarchive-zip-perl libapache2-mod-perl2 libxml-simple-perl libcompress-zlib-perl libdbi-perl libdbd-mysql-perl libapache-dbi-perl libnet-ip-perl libsoap-lite-perl libio-compress-perl libapache-session-perl libapache-rpc-perl libwww-perl libcrypt-ssleay-perl libdigest-md5-perl libmojolicious-perl
```

Instalar PHP y librerías:

```
sudo apt install php8.x -y
sudo apt install php8.x-mysql php8.x-zip php8.x-gd php8.x-mbstring php8.x-curl php8.x-xml php8.x-soap -y
```

Activar módulo Perl en Apache:

```
sudo a2enmod perl
```

## 📝 Configuración de PHP

Editar los siguientes archivos:

```
sudo nano /etc/php/8.x/apache2/php.ini
sudo nano /etc/php/8.x/cli/php.ini
```

Ajustar los parámetros:

```
short_open_tag = On
post_max_size = 1024M
upload_max_filesize = 256M
```

## 🗄️ Creación de Base de Datos y usuario

```
mysql -u root -p
CREATE DATABASE ocsweb;
CREATE USER 'ocs'@'localhost' IDENTIFIED BY '***';
GRANT ALL PRIVILEGES ON ocsweb.* TO 'ocs'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
quit
```

**Recomendación:** Mantener nombres de base de datos y usuario predeterminados para facilitar la configuración posterior.

## 📥 Descarga e instalación de OCS Inventory NG

```
cd /opt
sudo wget https://github.com/OCSInventory-NG/OCSInventory-ocsreports/releases/download/2.12.1/OCSNG_UNIX_SERVER-2.12.1.tar.gz
tar -xzvf OCSNG_UNIX_SERVER-2.12.1.tar.gz
cd OCSNG_UNIX_SERVER-2.12.1
./setup.sh
```

Responder a las preguntas del instalador pulsando ENTER o confirmando valores predeterminados, según corresponda.

## ⚙️ Configuración de Apache y permisos

Habilitar configuraciones:

```
sudo a2enconf ocsinventory-reports.conf
sudo a2enconf z-ocsinventory-server.conf
sudo a2enconf zz-ocsinventory-restapi.conf
```

Cambiar permisos de carpeta:

```
sudo chown -R www-data: /var/lib/ocsinventory-reports/
```

Reiniciar Apache:

```
sudo systemctl restart apache2
```

## 🌐 Acceso al asistente web

Acceder a `http://ip-servidor/ocsreports` y completar la conexión a la base de datos usando:

| Campo | Valor |
|-----------|----------------|
| MySQL login | ocs |
| MySQL password | *** |
| Name of Database | ocsweb |
| MySQL hostname | localhost |
| MySQL Port | 3306 |
| Enable SSL | NO |

El resto de opciones se dejan vacías.

---
