# 🌐 Linux Dotfiles & Setup Automation

Este repositorio contiene mi configuración personalizada de Arch Linux lista para usarse en otros sistemas basados en Linux.  
Permite instalar de forma automática todos mis programas, fuentes y ajustes visuales en cualquier máquina nueva, manteniendo la misma experiencia de uso.

## ✨ Características

- **Instalación automática de paquetes** adaptada a múltiples distribuciones:
  - Arch / Manjaro (`pacman`)
  - Ubuntu / Debian (`apt`)
  - Fedora (`dnf`)
  - openSUSE (`zypper`)
- **Configuraciones personalizadas** para:
  - [Awesome WM](https://awesomewm.org/)
  - Picom
  - Polybar
  - Rofi
  - Warp Terminal
  - Alacritty
  - Zsh + Oh My Zsh + Powerlevel10k
- **Plugins para Zsh**:
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
  - [fzf](https://github.com/junegunn/fzf)
- **Fuentes Nerd Font personalizadas** (Iosevka, Symbols, Fira Code, Terminus)
- **Sistema de enlaces simbólicos** para replicar la configuración en `~/.config` y otros directorios.
- **Instalación no destructiva**: no sobrescribe configuraciones existentes sin confirmación.

## 📂 Estructura del repositorio

```

.
├── config/           # Archivos de configuración de aplicaciones
├── fonts/            # Fuentes personalizadas (TTF / OTF / Iosevka)
├── packages/         # Lista de paquetes a instalar
├── scripts/          # Scripts de instalación y configuración
└── setup.sh          # Script principal

```

## 🚀 Instalación

1. Clona el repositorio:
    ```bash
    git clone https://github.com/zw9seq/dotfiles.git ~/dotfiles
    cd ~/dotfiles
    ```

2. Ejecuta el script principal:

   ```bash
   chmod +x setup.sh
   chmod +x scripts/*
   chmod +x config/backup.sh
   ./setup.sh
   ```

3. Sigue las instrucciones en pantalla para:

   * Instalar dependencias
   * Instalar fuentes
   * Crear enlaces simbólicos de configuración

## ⚙️ Personalización

* Edita `packages/common.txt` para añadir o quitar paquetes.
* Edita `config/backup.sh` para establecer tu ruta de backups.
* Modifica cualquier archivo en `config/` para ajustar la configuración de tus programas.
* Las fuentes se encuentran en `fonts/` y se instalan en `~/.local/share/fonts`.

## 📌 Requisitos

* Conexión a internet
* Un gestor de paquetes soportado (`pacman`, `apt`, `dnf`, `zypper`)
* Permisos de `sudo` para instalar paquetes

## 📝 Notas

* Este setup está optimizado para **Arch Linux**, pero es compatible con otras distribuciones Linux.

---

**Autor:** zw9seq
📅 Creado con 💻 y ☕