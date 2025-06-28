<h1 align="center">Instalación de GLPI en Ubuntu</h1>

Lo primero que haremos será instalar apache, que es donde correrá GLPI:
``` 
sudo apt-get install apache2
```
Una vez hemos instalado apache, instalaremos un SGBD que en nuestro caso será MariaDB:
``` 
sudo apt-get install mariadb-server
```
Ejecutamos el siguiente comando para establecer la contraseña de root:
```
mysql_secure_installation
```
Nos hará diferentes preguntas de configuración que responderemos de la siguiente manera:
```
Switch to unix_socket authentication [Y/n] n
Change the root password [Y/n] y
Remove anonymous users? [Y/n] y
Disallow root login remotely? [Y/n] n
Remove test database and access to it? [Y/n] y
Reload privilege tables now? [Y/n] y
```


También necesitaremos instalar php ya que GLPI trabaja con este:
```
sudo apt install php libapache2-mod-php
```
Ya tenemos lo imprescindible para instalar GLPI. Ahora descargamos la versión de GLPI desde la <a href="https://glpi-project.org/es/descargar-software/">página oficial</a>:
```
wget https://github.com/glpi-project/glpi/releases/download/10.0.x/glpi-10.0.x.tgz
```
La descomprimimos y la movemos al directorio de nuestro servidor web:
```
tar -xzf glpi-10.0.x.tgz
sudo mv glpi/var/www/html
```
Ahora ya podriamos acceder al asistente de instalación pero antes, haremos un par de pasos previos para poder instalarlo.
- Primero de todo cambiaremos los permisos de la carpeta de GLPI:
```
sudo chown -R www-data:www-data /var/www/html/glpi
```
- A continuación instalaremos unas extensiones y dependencias necesarias para la instalación:
```
sudo apt install php8.1-{mysql,xml,curl,gd,intl,ldap,bz2,zip,mbstring} php-cas
```
- Por último crearemos la base de datos sobre la que trabajará GLPI:
```
sudo mysql -u root -p
CREATE DATABASE glpi;
quit
```

Llega el momento de acceder al GLPI mediante el navegador para poder acceder al asistente de instalación. Para acceder pondremos la ip o dominio del servidor/glpi(ej: 192.168.10.10/glpi). 
Una vez estemos dentro le daremos a continuar eligiendo las opciones según nuestras preferencias hasta que lleguemos al primer paso de la configuración:
- Paso 1: SQL server: ```ip o dominio del servidor``` - SQL user: ```root``` - SQL password: ```contraseña de root```
- Paso 2 y 3: Elegimos la base de datos que hemos creado para GLPI y la conectamos.
- Paso 4, 5 y 6: Le damos a continuar hasta que nos ponga que la instalación ha finalizado.

Usuarios y contraseñas predeterminados
- glpi/glpi
- tech/tech
- normal/normal
- post-only/postonly

Nada más entrar podremos ver que GLPI nos muestra tres o cuatro advertencias (depende de la versión) las cuales tendremos que solucionar:
```
1- For security reasons, please change the password for the default users: glpi post-only tech normal
2- For security reasons, please remove file: install/install.php
3- Web server root directory configuration is not safe as it permits access to non-public files. See installation documentation for more details.
4- PHP directive "session.cookie_httponly" should be set to "on" to prevent client-side script to access cookie values
```
1- La primera será cambiar la contraseña de los usuarios que vienen predeterminados. Para ello nos iremos a la parte de administración, seleccionamos el usuario al que queremos cambiarle la contraseña y en acciones le cambiamos la contraseña.

2-La segunda advertencia se solucionará simplemente borrando el archivo de instalación de GLPI:
```
sudo rm /var/www/html/glpi/install/install.php
```
3- La tercera consistirá en editar el archivo de configuración de apache para que no se pueda acceder desde el navegador a archivos que no son públicos:
```
sudo nano /etc/apache2/sites-available/000-default.conf
```
En este fichero cambiaremos el DocumentRoot a: 
```
DocumentRoot /var/www/html/glpi
```
Y añadiremos las siguientes líneas:
```
        <Directory /var/www/html/glpi/public>
                Require all granted
                RewriteEngine On
                RewriteCond %{REQUEST_FILENAME} !-f
                RewriteRule ^(.*)$ index.php [QSA,L]
        </Directory>
```
Una vez guardado los cambios, se debe de habilitar rewrite, para poder hacerlo se hace ejecutando el comando:
```
sudo a2enmod rewrite
sudo systemctl restart apache2
```
4- Por último tendremos que establecer el parámetro ‘session.cookie_httponly’ en ‘on’ en el fichero de configuración de php de apache:
```
sudo nano /etc/php/8.x/apache2/php.ini
```
En este fichero buscaremos la línea que contenga el siguiente parámetro y lo pondremos en "on":
```
session.cookie_httponly = on
```
<b>Advertencia adicional:</b> si vamos a Configuración –> General –>Sistema, veremos una advertencia que dice lo siguiente:
```
Timezones seems not loaded, see https://glpi-install.readthedocs.io/en/ … .Timezones seems not loaded, see https://glpi-install.readthedocs.io/en/ … zones.html.
```
Para solucionarla solamente habrá que ejecutar el siguiente comando:
```
sudo mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -p -u root mysql
```

