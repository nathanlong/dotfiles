# Dotfiles

These are my personal dotfiles for my web design and front-end development
environment.

---

###Installation

Clone the files into your home directory:

    git clone git://github.com/nathanlong/dotfiles.git ~

`cd` into the dotfile directory and run the coupler

    ./coupler.sh

This will initialize all submodules and create symlinks for all relevant
files. It will overwrite any files that already exist, so be aware!

---

###Secret Places For Your Secrets

Need to add machine specific settings? I know I do. So there are a few places
I source for extra settings:

For bash:

    ~/.extra

Anything here will be sourced by the `.bash_profile`

For git:

    ~/.gitsecrets

Anything here will be sourced by `.gitconfig`. (Requires git version 1.7.10+).
Also I use the new git credential checker that stores your github info in the
osx keychain. Visit the github help pages to make sure you're set up for that.
Check for it on your machine by running:

    git credential-osxkeychain

---

###Additional Files for Vim

I keep Vim's backup files in a directory called `tmp` as well as the
YankRing plugin's history file, so be sure to either make it yourself or run
the command: 

    mkdir ~/tmp

I also keep a file called `.vimbookmarks` in my home directory that allows me
to quickly navigate to projects and edit them on the fly. You'll also have to
create this file or remove the reference from the `.vimrc`. I use the leader
key plus a number to store my current project directorys. Something like: 

    map <leader>1 :cd /path/to/directory1/<cr>
    map <leader>2 :cd /path/to/directory2/<cr>

**Happy Vimming!**


---

###A Note on Updating Vim Submodules

With git submodules, if `git submodule update` does not update your
submodules after you've checked them out, try:

    git submodule foreach git pull origin master
    git submodule update

(If you use command-t, you'll have to rebuild it after an update with `rake
make`.)
