# Load .setup, .exports, .aliases, .functions and .extra
for file in ~/.dotfiles/.{setup,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

# ~/.bashrc.local can be used for settings you don’t want to commit
if [ -f ~/.bashrc.local ]; then
   source ~/.bashrc.local
fi

# Load Bashmarks
source ~/.dotfiles/bin/bashmarks.sh
