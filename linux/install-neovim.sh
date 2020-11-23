#!/bin/bash

sudo yum install -y fuse fuse-sshfs

if [ ! -e "/usr/local/bin/nvim" ]; then
    sudo curl -o /usr/local/bin/nvim -LJO https://github.com/neovim/neovim/releases/download/v0.4.4/nvim.appimage
    sudo chmod 755 /usr/local/bin/nvim
fi

mkdir -p ${HOME}/.config/nvim
cat <<EOF > ${HOME}/.config/nvim/init.vim
syntax on
set termguicolors
set background=dark         # "dark" or "light", used for highlight colors
set autoread=on             # autom. read file when changed outside of Vim

set autoindent=on           # take indent for new line from previous line
set shiftwidth=4            # number of spaces to use for (auto)indent step

set tabstop=4               # number of spaces that <Tab> in file uses
set softtabstop=4           # number of spaces that <Tab> uses while editing
set expandtab               # use spaces when <Tab> is inserted

set pastetoggle=<F11>       # key code that causes 'paste' to toggle
EOF

GREP_VAR="$(grep -q nvim ${HOME}/.bashrc)"
if [ -n "${GREP_VAR}" ]; then
cat <<EOF > ${HOME}/.bashrc

# neovim
alias vi=\"nvim\"
alias vim=\"nvim\"
alias vimdiff=\"nvim -d\"
EOF
fi
