#! /bin/bash

####################
# Hecho por zw9seq #
####################

set -e

installationFile="packages/common.txt"

# Verify if 'common.txt' exists
if [ ! -f $installationFile ]; then
  echo "The file '$installationFile' doesn't exist. Aborting the installation."
  exit 1
fi

echo ">> Detecting the package manager..."

# Detect the package management system
if command -v apt-get &> /dev/null; then
    sudo apt-get update
    INSTALL_CMD="sudo apt-get install -y"
elif command -v dnf &> /dev/null; then
    INSTALL_CMD="sudo dnf install -y"
elif command -v pacman &> /dev/null; then
    sudo pacman -Syu --noconfirm
    INSTALL_CMD="sudo pacman -S --noconfirm --needed"
elif command -v zypper &> /dev/null; then
    INSTALL_CMD="sudo zypper install -y"
else
    echo "The package manager couldn't be detected. Aborting the installation."
    exit 1
fi

# Read 'common.txt' and install the packages
echo ">> Installing dependencies..."

while IFS= read -r package
do
  if [ -n "$package" ]; then  # Verify that the line isn't empty
    echo "Installing $package..."
    $INSTALL_CMD "$package"
  fi
done < "$installationFile"

echo ">> Installation completed!"