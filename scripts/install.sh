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

echo -e "/n>> Detecting the package manager.../n"
sleep 1

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
    echo -e "/nThe package manager couldn't be detected. Aborting the installation."
    sleep 1
    exit 1
fi

# Read 'common.txt' and install the packages
echo -e "/n>> Installing dependencies.../n"
sleep 1

while IFS= read -r package
do
  if [ -n "$package" ]; then  # Verify that the line isn't empty
    echo -e "/nInstalling $package..."
    $INSTALL_CMD "$package"
  fi
done < "$installationFile"

echo -e "/n>> Installation completed!"