#!/usr/bin/env bash

# bootstrap.sh

# Used to install and update the dotfiles repository

cd "$(dirname "${BASH_SOURCE[0]}")"

git pull origin master

rsync --exclude-from "exclude_list.txt" -avh --no-perms . ~
source ~/.bashrc

cd "$OLDPWD"
