#! /bin/bash

####################
# Hecho por zw9seq #
####################

set -e

bash scripts/install.sh
bash scripts/install_fonts.sh
bash scripts/zsh_config.sh

while true; do

    read -rp "Do you want to create symlinks to the dotfiles? (y/n): "  res

    case $res in
        yes|Yes|y|Y)
            bash scripts/symlinks.sh
            echo ">> The setup has finished. Exiting."
            exit 0
        ;;

        no|No|n|N)
            echo ">> The setup has finished. Exiting."
            exit 0
        ;;

        *)
            echo -e "\n>> Invalid option, please try again"
            sleep 1
        ;;
    esac
done