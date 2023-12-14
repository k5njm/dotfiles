#!/bin/bash

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Application installs.
# For MacOS, use the provided `Brewfile`
# For Linux, use dnf with the embedded list 
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Check if Homebrew is installed
    if [ ! -f "`which brew`" ]; then
        echo 'Installing homebrew'
        /bin/bash -c "NONINTERACTIVE=1 $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo 'Updating homebrew'
        brew update
    fi
    export PATH=/opt/homebrew/bin:$PATH && brew bundle

    # Specify the preferences directory
    defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "$SCRIPTPATH/iterm2.plist"
    # Tell iTerm2 to use the custom preferences in the directory
    defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

elif command -v dnf >/dev/null 2>&1; then
    echo "dnf detected, proceeding with installations."
    sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf -y install \
    barrier \
    code \
    discord \
    ffmpeg \
    gh \
    git \
    htop \
    jq \
    ncdu \
    tmux \
    toilet \
    tree \
    vim \
    zsh
else
    echo "dnf not found, aborting installations."
fi


echo 'Installing oh-my-zsh'
# Check if oh-my-zsh is installed
OMZDIR="$HOME/.oh-my-zsh"
if command -v omz > /dev/null; then
    echo 'Upgrading oh-my-zsh'
    omz update
else
    echo 'Installing oh-my-zsh'
    /bin/sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi

# Change default shell
if [ "$(basename "$SHELL")" != "zsh" ]; then
    echo 'Changing default shell to zsh'
    chsh -s /bin/zsh
else
    echo 'Already using zsh'
fi
