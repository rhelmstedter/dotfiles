#!/usr/bin/env bash

brew update && brew upgrade

# Install Brew Packages
echo "Installing Brew Python..."
brew install python

# Install MacOS Applications
echo "Installing MacOS Applications..."
brew install --cask amazon-music
brew install --cask brave-browser
brew install --cask google-chrome
brew install --cask iterm2
brew install --cask kindle
brew install --cask licecap
brew install --cask postman
brew install --cask slack
brew install --cask zoom
brew install --cask zotero

# Install packages
echo "Installing packages..."
brew install exa
brew install exercism
brew install fd
brew install fzf
brew install gh
brew install git
brew install haste-client
brew install htop
brew install inkscape
brew install iterm2
brew install lua
brew install neovim
brew install pandoc
brew install ripgrep
brew install slack
brew install speedtest-cli
brew install tldr
brew install tmux
brew install tree
brew install zsh

# Install Source Code Pro Font
echo "Installing fonts..."
brew tap homebrew/cask-fonts
brew cask install font-source-code-pro
brew cask install font-fantasque-sans-mono
brew cask install font-mononoki-nerd-font
brew cask install font-sauce-code-pro-nerd-font
brew cask install font-jetbrains-mono-nerd-font
