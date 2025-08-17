# 🌐 Linux Dotfiles & Setup Automation

Este repositorio contiene mi configuración personalizada de Arch Linux lista para usarse en otros sistemas basados en Linux.  
Permite instalar de forma automática todos mis programas, fuentes y ajustes visuales en cualquier máquina nueva, manteniendo la misma experiencia de uso.

## Vista previa
---

Insertar fotos de previsualizacion del resultado de la configuracion

---

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

```text
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
cd ~/
git clone https://github.com/zw9seq/archFiles.git ~/dotfiles
cd ~/dotfiles
```

2. Ejecuta el script principal:

```bash
chmod +x setup.sh
chmod +x scripts/*
chmod +x config/backup.sh
./setup.sh 
```

3. Instalar paquetes manualmente:

    Debes instalar los siguientes paquetes de forma manual:
   - VS Code
   - Warp Terminal  

    O configurar los atajos de Awesome para usar las aplicaciones que desees

## Configuracion post-instalación

Una vez terminada la instalación automatica con el script, debes modificar los siguientes ficheros para que la configuración funcione correctamente.

- ### **rc.lua**

El archivo se encuentra en la ruta config/awesome/ . Debes cambiar las apariciones de **"[USER]"** por el nombre de tu usuario en las tres siguientes líneas:

```lua
beautiful.init("/home/[USER]/.config/awesome/themes/default/theme.lua")
beautiful.wallpaper = "/home/[USER]/.config/awesome/themes/default/Vagabond2.jpg"
awful.spawn.with_shell("/home/[USER]/.config/polybar/launch.sh &")
```

- ### **config.ini**

Este archivo está en la ruta config/polybar/ . En él, se definen los modulos de la barra superior de la pantalla.

**Modulo izquierdo**: Puedes cambiar el icono del SO en la siguiente linea:

```ini
exec = echo "<U+F303>"
```

**Modulo central**: Dependiendo del tamaño de tu pantalla, puede que este modulo no se muestre en el centro; modifica la siguiente linea:

```ini
[bar/center]
...
offset-x = 45%
```

**Modulo derecho**: Dependiendo del tamaño de tu pantalla, puede que este modulo no se muestre en derecha; modifica la siguiente linea:

```ini
[bar/right]
...
offset-x = 82.5%
```

Si quieres ver el almacenamiento de un punto de montaje diferente a "/", cambia la siguiente linea:

```ini
[module/filesystem]
...
mount-0 = /
```

Si estas usando un portatil, descomenta la linea que contiene el modulo "battery" para monitorizar la batería de tu equipo:

```ini
[bar/right]
...
modules-right = memory backup filesystem pulseaudio sysmenu
;modules-right = memory backup filesystem pulseaudio battery sysmenu
```

- ### **powermenu.sh**

El archivo se encuentra en config/rofi/ . Debes cambiar la aparición de "[USER]" en la siguiente línea por el nombre de tu usuario:

```bash
$lock)
  i3lock --indicator \
  -i "/home/[USER]/.config/rofi/themes/Batman.jpg" \
  ...
```

- ### **backup.sh**

La ruta del archivo es config/backup/ . Debes modificar la siguiente linea para especificar los directorios a copiar y el destino de la copia:

```bash
tar -cpzf /[YourBackupStorage]/backup-"$cdate".tar.gz /[Directory1] /[Directory2] ...
```

---

Si el comando "cat" no funciona, debes revisar la linea `alias cat='/usr/bin/bat'` del archivo config/.zshrc. Busca donde se encuentra el ejecutable de `bat` y sustituye la ruta.

## ⚙️ Personalización

- Edita `packages/common.txt` para añadir o quitar paquetes.
- Edita `config/backup.sh` para establecer tu ruta de backups.
- Modifica cualquier archivo en `config/` para ajustar la configuración de tus programas.
- Las fuentes se encuentran en `fonts/` y se instalan en `~/.local/share/fonts`.

## 📌 Requisitos

- Conexión a internet
- Un gestor de paquetes soportado (`pacman`, `apt`, `dnf`, `zypper`)
- Permisos de `sudo` para instalar paquetes

## 📝 Notas

- Este setup está optimizado para **Arch Linux**, pero es compatible con otras distribuciones Linux.

---

**Autor:** zw9seq
📅 Creado con 💻 y ☕
