#! /bin/bash

####################
# Hecho por zw9seq #
####################

set -e

FONT_DIR="$HOME/.local/share/fonts"

echo ">> Installing fonts in $FONT_DIR..."

mkdir -p "$FONT_DIR"

cp -r fonts/TTF/* "$FONT_DIR"
cp -r fonts/OTF/* "$FONT_DIR"
cp -r fonts/Iosevka/* "$FONT_DIR"

# Restart the font cache
echo ">> Fonts installed! Restarting the fonts cache..."
sleep 1
fc-cache -fv