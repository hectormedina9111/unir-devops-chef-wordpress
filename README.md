# Despliegue Automatizado de WordPress con Chef y Vagrant 🚀

Este proyecto utiliza **Vagrant** para la orquestación de la infraestructura y **Chef** (vía el provisioner `chef_solo` o `chef_zero`) para la configuración automatizada del stack de WordPress.

## 📋 Requisitos

* **Vagrant** (v2.2+)
* **VirtualBox**

## 🛠️ Stack Tecnológico (Chef Recipes)
El aprovisionamiento mediante Chef se encarga de:
1.  **Servidor Web:** Instalación y configuración de Apache.
2.  **Base de Datos:** MySQL/MariaDB y creación de la BD para WordPress.
3.  **Lenguaje:** PHP con las extensiones necesarias.
4.  **Aplicación:** Descarga y configuración de los archivos de WordPress.

## 🚀 Comandos de Vagrant para ejecutar el proyecto

Ejecuta estos comandos en la carpeta raíz donde se encuentra tu `Vagrantfile`:

### 1. Levantar y Aprovisionar
Este comando crea la VM y lanza las recetas de Chef para instalar WordPress.
```bash
vagrant up