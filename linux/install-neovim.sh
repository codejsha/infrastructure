#!/usr/bin/bash

sudo yum install -y fuse fuse-sshfs

if [ ! -e "/usr/local/bin/nvim" ]; then
    sudo curl -o /usr/local/bin/nvim -LJO https://github.com/neovim/neovim/releases/download/v0.4.4/nvim.appimage
    sudo chmod 755 /usr/local/bin/nvim
fi

mkdir -p ${HOME}/.config/nvim
cat <<EOF > ${HOME}/.config/nvim/init.vim
syntax on
set termguicolors
set background=dark

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set pastetoggle=<F11>
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
