##
## Creates symlinks for the dotfiles
##

########## Variables
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
olddir=~/dotfiles_old             # old dotfiles backup directory
files="vimrc bash_aliases aliases functions screenrc banner_art i3status.conf tmux.conf ctags eclimrc xinitrc Xresources inputrc XresourcesHIDPI gitignore"    # list of files/folders to symlink in homedir

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

echo "Moving i3 config file to $olddir"

# in case a i3 config folder doest not exist
mkdir -p ~/.i3/

mv ~/.i3/config ~/dotfiles_old/

echo "Creating symlink to ~/.i3/config file in home directory."

ln -s $DIR/i3config ~/.i3/config

ln -s $DIR/autoxrandr ~/bin/autoxrandr

# installing vundle
echo "Installing vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing universal ctags"
mkdir -p ~/opt/
(cd ~/opt && git clone git@github.com:universal-ctags/ctags.git && ./autogen.sh && ./configure && make && sudo make install)

echo "Installing vim plugins and updating it"
vim +PlugInstall +qall

# installing node
curl https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
source ~/.nvm/nvm.sh

echo "Installing global node modules"
npm install -g tern gulp grunt-cli karma phantomjs eslint jscs js-beautify

echo "Installing jsctags from the private repo: https://github.com/ramitos/jsctags.git"
npm install -g git+https://github.com/ramitos/jsctags.git


echo "Installing VIM plugging tern dependencies"
cd ~/.vim/bundle/tern_for_vim
nvm install node
nvm use node
npm install

echo "Installing VIM plugging YCM dependencies"
cd ~/.vim/bundle/YouCompleteMe

echo "Compiling dependencies"
./install.py --all

cd $DIR

echo "Global Ignored files:"
cat ~/.gitignore
git config --global core.excludesfile '~/.gitignore'

echo "Enabling new settings"
. ~/.bash_aliases
