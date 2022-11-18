#!/usr/bin/env bash

# bootstrap.sh

# Used to install and update the dotfiles repository

OLDPWD_backup="$OLDPWD"
cd "$(dirname "${BASH_SOURCE[0]}")"

git pull origin master

rsync --exclude-from "exclude_list.txt" -avh --no-perms . ~
source ~/.bashrc

#Install fonts
echo -e "\nInstalling fonts..."
source install-fonts.sh

#Install Tmux Plugin Manager 
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

cd "$OLDPWD"
export OLDPWD="$OLDPWD_backup"
