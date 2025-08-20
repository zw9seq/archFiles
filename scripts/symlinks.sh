#! /bin/bash

####################
# Hecho por zw9seq #
####################

echo -e "/n>> Creating symlinks.../n"
sleep 1

DOTFILES_DIR="$HOME/dotfiles/config"

declare -A CONFIGS=(
  ["awesome"]="$HOME/.config/awesome"
  ["picom"]="$HOME/.config/picom"
  ["polybar"]="$HOME/.config/polybar"
  ["rofi"]="$HOME/.config/rofi"
  ["alacritty"]="$HOME/.config/alacritty"
  [".zshrc"]="$HOME/.zshrc"
  [".p10k.zsh"]="$HOME/.p10k.zsh"
  ["backup"]="$HOME/.local/bin/backup.sh"
)

for key in "${!CONFIGS[@]}"; do
  src="$DOTFILES_DIR/$key"
  dest="${CONFIGS[$key]}"

  echo "→ Linking $src → $dest"

  # Creates the directories if needed
  mkdir -p "$(dirname "$dest")"
  
  ln -sf "$src" "$dest"
done

echo -e "/n>> Symlinks created./n"
sleep 1