#!/bin/bash
set -o errtrace
set -o errexit
trap 'echo "${BASH_SOURCE[0]}: line ${LINENO}: func ${FUNCNAME[0]}: status ${?}"' ERR

######################################################################

function install_neovim_with_download {
    local NEOVIM_VERSION="0.4.4"

    sudo yum install -y fuse fuse-sshfs

    if [ ! -e "/usr/local/bin/nvim" ]; then
        sudo curl -o /usr/local/bin/nvim -LJO https://github.com/neovim/neovim/releases/download/v${NEOVIM_VERSION}/nvim.appimage
        sudo chmod 755 /usr/local/bin/nvim
    fi
}

function install_neovim_with_yum {
    sudo yum install -y epel-release
    sudo yum install -y neovim
    sudo yum install -y python36-neovim
}

function install_neovim_with_apt {
    sudo apt-get install neovim
    sudo apt-get install python3-neovim
}

######################################################################

# install_neovim_with_download
install_neovim_with_yum
# install_neovim_with_apt

mkdir -p ${HOME}/.config/nvim

cat <<EOF > ${HOME}/.config/nvim/init.vim
syntax on
set termguicolors
set background=dark
EOF

### add alias
# alias vi="nvim"
# alias vim="nvim"
# alias vimdiff="nvim -d"
