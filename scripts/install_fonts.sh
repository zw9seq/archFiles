#! /bin/bash

####################
# Hecho por zw9seq #
####################

set -e

FONT_DIR="$HOME/.local/share/fonts"

echo -e "/n>> Installing fonts in $FONT_DIR.../n"

mkdir -p "$FONT_DIR"

cp -r fonts/TTF/* "$FONT_DIR" 2>/dev/null
cp -r fonts/OTF/* "$FONT_DIR" 2>/dev/null
cp -r fonts/Iosevka/* "$FONT_DIR" 2>/dev/null

# Restart the font cache
echo ">> Fonts installed! Restarting the fonts cache..."
sleep 1
fc-cache -fv