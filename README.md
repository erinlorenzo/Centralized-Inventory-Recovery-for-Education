
# Centralized Inventory and Recovery System for Educational Enviroments

📖 [Leer esta documentación en español](README-es.md)

---

## 🎓 Introduction

This project was developed as part of my Final Degree Project in Systems and Network Administration with a specialization in cybersecurity. It implements a centralized system for inventory management, automated image restoration, user directory management, and vulnerability scanning in educational environments.

The system integrates multiple open-source tools to provide complete control and security over devices in a classroom or laboratory setting.

---

## 🚀 Overview

The project implements an inventory management system based on **GLPI**, enhanced with several additional functionalities. The system collects detailed information about the hardware, software, and network status of all devices using **OCS Inventory**.

Beyond continuous device management and monitoring, the project includes a **backup and image restoration system** using **FOG Project**. This ensures rapid recovery and data availability in case of failures or incidents.

To strengthen network security, the system incorporates **Nessus**, which performs automated vulnerability scans and detects potential weaknesses in software and configurations.

Clients are grouped into roles typical of educational environments (e.g., Teacher, DAM, DAW, ASIR). Based on the group, each device receives specific configurations, operating systems, and software packages, making deployment fast and fully automated.

---

## 🖥️ Key Features

✅ **Centralized inventory management** with GLPI and OCS Inventory.  
✅ **Disk imaging and restoration** with FOG Project (PXE boot).  
✅ **Automated vulnerability scanning** using Nessus.  
✅ **Generic frozen user account:**  
- Each client includes a generic user whose home directory is reset on every reboot.
- Ensures privacy and a clean environment on each session.

✅ **Samba network share integration:**  
- Users can log in/out to their personal Samba folder via desktop shortcuts.
- Mounted resources appear on the desktop and are safely disconnected on logout.

✅ **Role-based device configuration:**  
- Devices automatically receive their OS, software, and configuration based on assigned group.

---

## ⚙️ System Components

### GLPI + OCS Inventory
- Collects detailed hardware/software/network data from all clients.
- Provides a web-based interface for asset and ticket management.

### FOG Project
- Creates and deploys disk images to client machines via PXE boot.
- Simplifies mass deployment of configurations.

### Samba AD
- Manages user directories and permissions.
- Provides personal network folders accessible via login scripts.

### Nessus
- Regularly scans the network for vulnerabilities.
- Helps identify and mitigate security risks.

### Generic User Environment
- Automatic login to a generic account after idle timeout.
- Frozen home directory restored at every reboot using reset scripts.
- Supports persistent personal storage via Samba network shares.

---

## 📂 File Structure

```
/
├── scripts/
│   ├── createUser.sh
│   ├── resetHome.sh
│   ├── loginSMB.sh
│   └── logoutSMB.sh
│   └── ocsAgent.sh
├── FOG.md
├── GLPI.md
├── OCS_Inventory_Server.md
├── OCS_Inventory_LinuxAgent.md
├── Nessus.md
├── Samba_Configuration.md
├── Generic_User.md
├── README.md
└── README-es.md
```

---

## 📝 Installation & Setup

Refer to the following documents for detailed installation and configuration instructions:

- [FOG Project Setup](FOG.md)
- [GLPI Installation & Configuration](GLPI.md)
- [OCS Inventory Server Setup](OCS_Inventory_Server.md)
- [OCS Inventory Linux Agent Setup](OCS_Inventory_LinuxAgent.md)
- [Nessus Setup](Nessus.md)

Each document includes step-by-step guides, screenshots, and recommended best practices.

---

## 👤 Author

**Erín Lorenzo Coto**  
Systems and Network Administrator specialized in Cybersecurity.

[LinkedIn Profile](www.linkedin.com/in/erín-lorenzo-coto) 
