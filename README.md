# Centralized-Inventory-Recovery-for-Education

📖 [Leer esta documentación en español](README-es.md)

This project was developed as part of my Final Degree Project in Systems and Network Administration with a specialization in cybersecurity. It implements an inventory management system based on GLPI, enhanced with several additional functionalities. The system is designed to collect detailed information about the hardware, software, and network status of all devices within the network using OCS Inventory. Additionally, it integrates an alert system to identify and log any abnormal or unauthorized behavior on devices, providing comprehensive control over the infrastructure.

Beyond continuous device management and monitoring, the project includes the deployment of a backup and image restoration system for computers. FOG Project will be used to deploy disk images via the pre-boot execution environment (PXE), ensuring data availability and rapid recovery in the event of failures or incidents.

To further strengthen network security, the implementation of an automated vulnerability scanning tool is planned. Nessus will be used to perform automated scans of network systems, allowing the identification of potential weaknesses in software and device configurations.

Clients will be grouped by roles similar to those in an educational environment (e.g., Teacher, DAM, DAW, ASIX). Based on these groups, the system will automate the operating system, software, and configurations for each device, so that when a new device is installed, simply specifying its group will configure it quickly and automatically.

