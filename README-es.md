
# Sistema Centralizado de Inventario y Restauración para Entornos Educativos

📖 [Read this documentation in English](README.md)

---

## 🎓 Introducción

Este proyecto ha sido desarrollado como parte de mi Trabajo de Fin de Grado en Administración de Sistemas y Redes con especialización en ciberseguridad. Implementa un sistema centralizado de gestión de inventario, restauración automatizada de imágenes, gestión de directorios de usuario y escaneo de vulnerabilidades en entornos educativos.

El sistema integra múltiples herramientas de código abierto para proporcionar control y seguridad total sobre los dispositivos en un aula o laboratorio.

---

## 🚀 Descripción General

El proyecto implementa un sistema de gestión de inventario basado en **GLPI**, mejorado con varias funcionalidades adicionales. El sistema recopila información detallada sobre el hardware, software y estado de red de todos los dispositivos mediante **OCS Inventory**. 

Además de la gestión y monitorización continua de los dispositivos, el proyecto incluye un **sistema de copia de seguridad y restauración de imágenes** usando **FOG Project**. Esto garantiza recuperación rápida y disponibilidad de datos en caso de fallos o incidentes.

Para reforzar la seguridad de la red, el sistema incorpora **Nessus**, que realiza análisis automatizados de vulnerabilidades y detecta posibles debilidades en el software y configuraciones.

Los clientes se agrupan en roles típicos de entornos educativos (por ejemplo: Profesor, DAM, DAW, ASIR). Según el grupo, cada dispositivo recibe configuraciones, sistemas operativos y paquetes de software específicos, haciendo el despliegue rápido y totalmente automatizado.

---

## 🖥️ Funcionalidades Clave

✅ **Gestión centralizada de inventario** con GLPI y OCS Inventory.  
✅ **Imágenes de disco y restauración** con FOG Project (arranque PXE).  
✅ **Escaneo automatizado de vulnerabilidades** usando Nessus.  
✅ **Cuenta de usuario genérica congelada:**  
- Cada cliente incluye un usuario genérico cuya carpeta personal se restablece en cada reinicio.
- Garantiza privacidad y un entorno limpio en cada sesión.

✅ **Integración con recursos compartidos de Samba:**  
- Los usuarios pueden iniciar/cerrar sesión en su carpeta Samba personal mediante accesos directos en el escritorio.
- Los recursos montados aparecen en el escritorio y se desconectan de forma segura al cerrar sesión.

✅ **Configuración de dispositivos según rol:**  
- Los dispositivos reciben automáticamente su sistema operativo, software y configuración según el grupo asignado.

---

## ⚙️ Componentes del Sistema

### GLPI + OCS Inventory
- Recopila datos detallados de hardware/software/red de todos los clientes.
- Proporciona interfaz web para gestión de activos e incidencias.

### FOG Project
- Crea y despliega imágenes de disco a los equipos clientes mediante arranque PXE.
- Facilita el despliegue masivo de configuraciones.

### Samba AD
- Gestiona directorios de usuario y permisos.
- Proporciona carpetas personales de red accesibles mediante scripts de login.

### Nessus
- Escanea regularmente la red en busca de vulnerabilidades.
- Ayuda a identificar y mitigar riesgos de seguridad.

### Entorno de Usuario Genérico
- Inicio de sesión automático en cuenta genérica tras tiempo de espera.
- Carpeta personal congelada restaurada en cada reinicio mediante scripts.
- Soporta almacenamiento personal persistente mediante recursos de red Samba.

---

## 📂 Estructura de Archivos

```
/
├── scripts/
│   ├── createUser.sh
│   ├── loginSMB.sh
│   ├── logoutSMB.sh
│   └── ocsAgent.sh
│   └── resetHome.sh
├── FOG.md
├── GLPI.md
├── Generic_User.md
├── Nessus.md
├── OCS_Inventory_LinuxAgent.md
├── OCS_Inventory_Server.md
├── README-es.md
├── README.md
└── Samba_Configuration.md
```

---

## 📝 Instalación y Configuración

Consulta los siguientes documentos para instrucciones detalladas de instalación y configuración:

- [Instalación de FOG Project](FOG.md)
- [Instalación y Configuración de GLPI](GLPI.md)
- [Configuración del usuario genérico](Generic_User.md)
- [Instalación de OCS Inventory Server](OCS_Inventory_Server.md)
- [Instalación de OCS Inventory Linux Agent](OCS_Inventory_LinuxAgent.md)
- [Instalación de Nessus](Nessus.md)
- [Configuración de Samba](Samba_Configuration.md)

Cada documento incluye guías paso a paso, capturas de pantalla y buenas prácticas recomendadas.

---

## 👤 Autor

**Erín Lorenzo Coto**  
Administrador de Sistemas y Redes especializado en Ciberseguridad.

[Perfil LinkedIn](www.linkedin.com/in/erín-lorenzo-coto)

