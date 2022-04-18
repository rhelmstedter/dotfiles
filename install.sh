# stow dotfiles
stow -R nvim
stow -R tmux
stow -R zsh

# add zsh as a login shell
command -v zsh | sudo tee -a /etc/shells

# use zsh as default shell
sudo chsh -s $(which zsh) $USER


