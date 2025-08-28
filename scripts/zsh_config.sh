#!/bin/bash

####################
# Hecho por zw9seq #
####################

set -e

echo -e "\n>> Configuring Zsh...\n"

# Install zsh
if ! command -v zsh &>/dev/null; then
    echo -e "\n>> Installing zsh...\n"
    if command -v apt-get &>/dev/null; then
        sudo apt-get install -y zsh
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm --needed zsh
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y zsh
    elif command -v zypper &>/dev/null; then
        sudo zypper install -y zsh
    fi
fi

# Install plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo e "\n>> Installing oh-my-zsh...\n"
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
        "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo ">> oh-my-zsh already installed."
fi

# Install Powerlevel10K
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo -e "\n>> Installing Powerlevel10k theme...\n"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo -e "\n>> Installing zsh-autosuggestions...\n"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo -e "\n>> Installing zsh-syntax-highlighting...\n"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Install fzf
if ! command -v fzf &> /dev/null; then
    echo -e "\n>> Installing fzf...\n"
    if command -v apt-get &> /dev/null; then
        sudo apt-get install -y fzf
    elif command -v pacman &> /dev/null; then
        sudo pacman -S --noconfirm --needed fzf
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y fzf
    fi
fi

# Stablish zsh as the default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo -e "\n>> Changing default shell to zsh...\n"
    chsh -s "$(which zsh)"
fi

echo -e "\n>> Zsh setup completed!\n"
