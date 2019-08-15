#!/usr/bin/env bash

function install_tools_init() {
    task_setup "install_tools" "Install Tools" "Install essential toolbelts"
}

function install_tools_run() {
    PLATFORM=$(settings_get "PLATFORM")
    if [ "$PLATFORM" = "darwin" ]; then

        # Install homebrew cask addon
        brew install caskroom/cask/brew-cask

        # Install GNU core
        brew tap homebrew/dupes
        brew install coreutils --with-default-names
        brew install findutils --with-default-names
        brew install gnu-indent --with-default-names
        brew install gnu-sed --with-default-names
        brew install gnutls
        brew install grep --with-default-names
        brew install gnu-tar --with-default-names
        brew install gawk

        # Install other CLI utilities
        brew install zsh
        brew install git
        brew install direnv
        brew install wget

        # Install OS X applications
        #brew cask install dropbox
        brew cask install google-chrome
        #brew cask install caffeine
        brew cask install iterm2
        #brew cask install vlc
        brew cask install go2shell
        brew cask install diskmaker-x
        #brew cask install appcleaner
        brew cask install visual-studio-code
        #brew cask install steam
        #brew cask install mplayerx
        #brew cask install sketch
        brew cask install macdown
        brew cask install kaleidoscope

        # Font management
        brew tap caskroom/fonts
        brew cask install font-input
        brew cask install font-open-sans
        brew cask install font-roboto
        brew cask install font-roboto-slab
    elif [ "$PLATFORM" = "debian" ]; then
        # Instal flutter
        git clone -b beta https://github.com/flutter/flutter.git

        # Adding dart
        sudo sh -c 'curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
        sudo sh -c 'curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
        sudo apt-get update
        sudo apt-get install -y dart

        # Adding chrome
        wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
        sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
        sudo apt-get update
        sudo apt-get install -y google-chrome-stable
        sudo apt-get install -f -y

        # Adding vscode
        curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
        sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
        sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
        sudo apt-get update
        sudo apt-get install -y code

        # install telegram
        sudo apt-add-repository ppa:atareao/telegram -y
        sudo apt-get update
        sudo apt-get install -y telegram


        # install java
        sudo apt-get install -y openjdk-8-jdk

        # install docker
        curl -fsSL get.docker.com | sh

        # install arc theme
        sudo apt-add-repository ppa:fossfreedom/arc-gtk-theme-daily -y
        sudo apt-get update
        sudo apt-get install -y arc-theme

        # install arc icon
        git clone https://github.com/horst3180/arc-icon-theme --depth 1 && cd arc-icon-theme
        ./autogen.sh --prefix=/usr
        sudo make install

        # install android studio
        sudo apt-add-repository ppa:maarten-fonville/android-studio -y
        sudo apt-get update
        sudo apt-get install -y android-studio
        /opt/android-studio/bin/studio.sh &

        # Adding hyper
        curl -L https://releases.hyper.is/download/deb > hyper.deb
        sudo dpkg -i hyper.deb
        rm hyper.deb
    elif [ "$PLATFORM" = "arch" ]; then
        # Instal flutter
        git clone -b beta https://github.com/flutter/flutter.git

        # Adding dart
        yaourt -S dart --noconfirm
        # Adding Chrome
        yaourt -S google-chrome --noconfirm
        # installing telegram
        yaourt -S telegram-desktop --noconfirm
        # installing vscode
        yaourt -S visual-studio-code-bin --noconfirm
        # installing java
        yaourt -S jdk8 --noconfirm
        # installing docker
        if lsmod | grep loop &> /dev/null; then
            log_info "loop is loaded!"
        else
            log_info "loop is not loaded! Enabling it now"
            sudo tee /etc/modules-load.d/loop.conf <<< "loop"
            sudo modprobe loop
        fi
        yaourt -S docker --noconfirm
        sudo systemctl start docker.service
        sudo systemctl enable docker.service
        sudo gpasswd -a $USER docker
        # installing docker-compose
        yaourt -S docker-compose --noconfirm
        # installing android studio
        yaourt -S android-studio --noconfirm
        # installing tilix
        yaourt -S tilix --noconfirm
        # install virtualbox
        yaourt -S virtualbox-bin --noconfirm
        # install vagrant
        yaourt -S vagrant --noconfirm
        # installing direnv
        yaourt -S direnv --noconfirm
        # installing adapta theme
        yaourt -S adapta-gtk-theme --noconfirm
        # installing papirus-icon-theme
        yaourt -S papirus-icon-theme --noconfirm
        # installing zeal
        yaourt -S zeal --noconfirm
        sudo sed -i '/Exec=zeal %u/c\Exec=env QT_AUTO_SCREEN_SCALE_FACTOR=0 zeal %u' /usr/share/applications/zeal.desktop # fix ui scaling issue
        # installing slack
        yaourt -S slack-desktop --noconfirm
        
        # installing godot
        yaourt -S godot-bin --noconfirm

    elif [ "$PLATFORM" = "centos" ]; then
        # Ading vscode
        sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
        sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
        yum check-update
        sudo yum install -y code

    fi
    return ${E_SUCCESS}
}
