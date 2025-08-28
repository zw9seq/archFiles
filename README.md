# 🌐 Linux Dotfiles & Setup Automation

This repository contains my custom **Linux dotfiles and automation scripts**, originally designed for Arch Linux but fully adaptable to other major distributions.
The goal of this configuration is to provide an efficient, keyboard-driven, multitasking-friendly workflow while keeping a consistent setup across different machines.

With just one script, you can automatically install my favorite applications, fonts, and visual tweaks, and replicate the same environment anywhere.

---

## 📸 Preview

![screenshot1](https://github.com/zw9seq/zw9seq/blob/6fd141f208d700630e9fbdbb715bc6e066212250/misc/Aug20%3A%3A102140.png)
![screenshot2](https://github.com/zw9seq/zw9seq/blob/6fd141f208d700630e9fbdbb715bc6e066212250/misc/Aug20%3A%3A102521.png)

---

## ✨ Features

* **Automatic package installation** across multiple distros:

  * Arch / Manjaro (`pacman`)
  * Ubuntu / Debian (`apt`)
  * Fedora (`dnf`)
  * openSUSE (`zypper`)
* **Preconfigured environments**:

  * [Awesome WM](https://awesomewm.org/)
  * Picom
  * Polybar
  * Rofi
  * Alacritty
  * Zsh + Oh My Zsh + Powerlevel10k
* **Zsh plugins included**:

  * [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  * [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
  * [fzf](https://github.com/junegunn/fzf)
* **Custom Nerd Fonts** (Iosevka, Symbols, Fira Code, Terminus)
* **Symlink-based configuration system** for `~/.config` and related directories
* **Non-destructive installation**: existing configs are not overwritten without confirmation

---

## 📂 Repository Structure

```text
.
├── config/           # Application configuration files
├── fonts/            # Custom fonts (TTF / OTF / Iosevka)
├── packages/         # Package lists
├── scripts/          # Setup and utility scripts
└── setup.sh          # Main installation script
```

---

## 📌 Requirements

* Internet connection
* A supported package manager (`pacman`, `apt`, `dnf`, `zypper`)
* `sudo` privileges to install system packages

---

## 🚀 Installation

1. Clone the repository:

```bash
git clone https://github.com/zw9seq/archFiles.git ~/dotfiles
cd ~/dotfiles
```

2. Run the main script:

```bash
chmod +x setup.sh
chmod +x scripts/*
chmod +x config/backup.sh
./setup.sh 
```

3. **Manual steps**:

Visual Studio Code (**vscode**) must be installed manually. Alternatively, replace its launcher in **config/rc.lua** with your preferred IDE:

```lua
awful.key({ modkey }, "v",
   function ()
       awful.spawn("code") -- Change "code" to your IDE’s command
   end,
   { description = "open Visual Studio Code", group = "launcher" }
),
```

---

## 🔧 Post-Installation Setup

After running the setup script, a few files must be edited manually for full functionality:

* **rc.lua** (`config/awesome/`)
  Replace `[USER]` with your username and adjust paths for wallpaper, polybar launcher, and screenshot storage.

* **config.ini** (`config/polybar/`)
  Customize icons, module alignment, and battery module if running on a laptop.

* **powermenu.sh** (`config/rofi/`)
  Replace `[USER]` with your username in the lockscreen path.

* **backup.sh** (`config/backup/`)
  Define which directories should be included in your backup.

> If the `cat` command fails, adjust the `alias cat='/usr/bin/bat'` line in `.zshrc` to point to the correct `bat` binary path.

Once everything is configured, you must **reboot** the system and loggin choosing the `Awesome` window manager.

---

## ⌨️ Keyboard Shortcuts

This setup is fully **keyboard-driven**. Here are the essential keybindings for Awesome WM:

| Shortcut                     | Action                           |
| ---------------------------- | -------------------------------- |
| **Win + Arrows**             | Focus windows                    |
| **Win + Ctrl + Arrows**      | Move windows                     |
| **Win + Alt + Arrows**       | Resize windows                   |
| **Win + o**                  | Toggle floating mode             |
| **Win + Enter**              | Open terminal                    |
| **Win + d**                  | Application launcher (Rofi)      |
| **Win + f**                  | Open Firefox                     |
| **Win + v**                  | Open VSCode                      |
| **Win + Ctrl + r**           | Reload Awesome                   |
| **Win + w**                  | Close window                     |
| **Win + Ctrl + Shift + ↑/↓** | Adjust number of master windows  |
| **Win + h**                  | Minimize window                  |
| **Win + Ctrl + h**           | Restore minimized window         |
| **Win + m**                  | (Un)maximize window              |
| **Win + Ctrl + f**           | Toggle fullscreen                |
| **Win + \[Number]**          | Switch workspace                 |
| **Win + Shift + \[Number]**  | Move window to workspace         |
| **Win + Ctrl + \[Number]**   | Merge workspaces onto one screen |
| **Win + Right Click**        | Resize floating window           |
| **Win + Left Click**         | Move floating window             |
| **Win + c**                  | Screenshot selection (scrot)     |

---

## 👤 Author

**zw9seq**
📅 Built with 💻 + ☕

For more details: https://zw9seq.github.io/proyectos/archFiles
