#!/bin/bash
#
# Sets up the machine with essential utilities and bootstraps the dotfiles.

#
# Clone/pull the SaadBenn/dotfiles
PLATFORM=$(uname | tr "[:upper:]" "[:lower:]")
if [[ -d $HOME/.dotfiles ]]; then
    ( cd $HOME/.dotfiles; git pull; )
else
    if [ "$PLATFORM" = "linux" ]; then
        if hash yum >/dev/null 2>&1; then
            yum check-update
            sudo yum install -y git
        fi
        if hash apt-get >/dev/null 2>&1; then
            sudo apt update
            sudo apt install -y git
        fi
        if hash pacman >/dev/null 2>&1; then
            sudo pacman -S --noconfirm git
        fi
    fi
    git clone https://github.com/saadbenn/dotfiles ~/.dotfiles
fi

$HOME/.dotfiles/installer;
