#!/bin/bash

# Installs all dependencies needed
# Will update if already installed

set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Oh my zsh
if [ ! -d "$DOTFILES_DIR/.oh-my-zsh" ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git $DOTFILES_DIR/.oh-my-zsh
else
    (cd $DOTFILES_DIR/.oh-my-zsh; git pull)
fi

# Zsh syntax highlighting plugin
if [ ! -d "$DOTFILES_DIR/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git $DOTFILES_DIR/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
else
    (cd $DOTFILES_DIR/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting; git pull)
fi

# Zsh better autocompletion
if [ ! -d "$DOTFILES_DIR/.oh-my-zsh/custom/plugins/zsh-history-substring-search" ]; then
    git clone git://github.com/zsh-users/zsh-history-substring-search.git $DOTFILES_DIR/.oh-my-zsh/custom/plugins/zsh-history-substring-search
else
    (cd $DOTFILES_DIR/.oh-my-zsh/custom/plugins/zsh-history-substring-search; git pull)
fi

# Symfony console
if [ ! -d "$DOTFILES_DIR/.oh-my-zsh/custom/plugins/symfony-console" ]; then
    git clone https://github.com/mnapoli/zsh-symfony-console-plugin.git $DOTFILES_DIR/.oh-my-zsh/custom/plugins/symfony-console
else
    (cd $DOTFILES_DIR/.oh-my-zsh/custom/plugins/symfony-console; git pull)
fi

# Configures git
git config --global user.name "Matthieu Napoli"
git config --global user.email matthieu@mnapoli.fr
git config --global core.excludesfile '~/.gitignore_global'


# Files & directories to symlink
symlinks=".zshrc .oh-my-zsh .gitignore_global .composer .ssh/config"

# Create symlinks 
for symlink in $symlinks; do
    echo "Creating symlink for $symlink"
    if [ -h ~/$symlink ]; then
        echo "Skipping $symlink: symlink already exist"
    elif [ ! -e ~/$symlink ]; then
        ln -s $DOTFILES_DIR/$symlink ~/$symlink
    else
        echo "Error for $symlink: file already exist"
    fi
done
