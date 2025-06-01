#!/bin/bash
branch_flag="main"
CONFIG_DIR="$HOME/.config/nvim"

while getopts "b:" opt; do
  case $opt in
    b)
      branch_flag="OPTARG";;
    \?)
      echo "Usage: $0 [-b BRANCH]"
      exit 1;;
  esac
done


rm -rf ./nvim
mkdir nvim
cp -r "$CONFIG_DIR"/* ./nvim
git add .
COMMIT_MSG=${1:- "Neovim config files"}

current_branch=$(git branch --show-current)

if ["$current_branch" != "$branch_flag"]; then
  git checkout "$branch_flag"
fi

git commit -m "$COMMIT_MSG"
git push origin "branch_flag"
