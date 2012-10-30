#!/bin/bash
echo "Initializing dotfile transfer..."
cd "$(dirname "$0")"
git pull
git submodule init
git submodule update
function linkIt() {
    for file in .{bash_profile,bashrc,vim,vimrc,gvimrc,gitconfig}; do
        ln -sifF ~/.dotfiles/"$file" ~/"$file" 
    done
}
if [ "$1" == "--force" -o "$1" == "-f" ]; then
	linkIt
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		linkIt
	fi
fi
unset linkIt
mkdir ~/.dotfiles/.vim/sessions
mkdir ~/.dotfiles/.vim/tmp
touch ~/.dotfiles/.vim/tmp/vimbookmarks
touch ~/.vimsecrets
source ~/.bash_profile
echo "Transfer complete."

