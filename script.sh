#!/bin/bash

CONFIG_DIR="$HOME/.config/nvim"
cp -r "$CONFIG_DIR"/* ./nvim
git add .
COMMIT_MSG=${1:- "Neovim config files"}
git commit -m "$COMMIT_MSG"
git push origin main

