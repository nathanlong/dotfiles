# Load .setup, .exports, .aliases, .functions and .extra
for file in ~/.dotfiles/.{setup,exports,aliases,functions}; do
    [ -r "$file" ] && source "$file"
done
unset file

# ~/.extra can be used for settings you don’t want to commit
if [ -f ~/.extra ]; then
   source ~/.extra
fi
