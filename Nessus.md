
# Instalación y Configuración de Nessus

## 📚 Introducción

Nessus es una herramienta de escaneo de vulnerabilidades que permite identificar posibles fallos de seguridad en sistemas y redes. A continuación, se describen los pasos para instalarlo en Ubuntu, configurarlo para realizar escaneos periódicos y enviar los resultados por correo electrónico.

## 🔥 Instalación de Nessus

Descargar la última versión del paquete desde la [página oficial de Tenable](https://www.tenable.com/downloads/nessus). Por ejemplo:

```
wget https://www.tenable.com/downloads/api/v1/public/pages/nessus/downloads/nessus-10.x.x-ubuntu1110_amd64.deb
```

Instalar el paquete:

```
sudo dpkg -i nessus-10.x.x-ubuntu1110_amd64.deb
```

Iniciar el servicio:

```
sudo systemctl start nessusd
```

Acceder a la interfaz web en:

```
https://localhost:8834
```

Completar el asistente de instalación y activar la licencia.

## ⚙️ Configuración de Escaneo Periódico

1️⃣ Crear un nuevo escaneo programado desde la interfaz web: `New Scan` → elegir plantilla (por ejemplo, `Advanced Scan`).

2️⃣ Configurar las opciones de escaneo: direcciones IP o rangos, credenciales (si se necesitan escaneos autenticados), plugins, etc.

3️⃣ En la pestaña `Schedule` (Programar), habilitar la ejecución periódica y establecer la frecuencia deseada (diaria, semanal, etc.).

