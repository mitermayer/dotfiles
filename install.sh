#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
olddir=~/dotfiles_old             # old dotfiles backup directory
files="vimrc bash_aliases aliases functions screenrc banner_art"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $DIR directory"
cd $DIR
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $DIR/$file ~/.$file
done

# Installing dependencies
sudo apt-get update && sudo apt-get install vim-nox clang-3.5 python-dev libboost-dev python-py++ -y

# installing vundle
echo "Installing vundle"
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle

echo "Installing vim plugins and updating it"
vim +BundleInstall! +qall

echo "Installing VIM plugging tern dependencies"
cd .vim/bundle/tern_for_vim
npm install

echo "Installing jsctags"
npm install -g git://github.com/ramitos/jsctags.git

echo "Installing VIM plugging YCM dependencies"
cd ~/.vim/bundle/YouCompleteMe

echo "Compiling dependencies"
./install.sh

cd $DIR

echo "Enabling new settings"
. ~/.bash_aliases
