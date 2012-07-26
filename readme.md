# Dotfiles

These are my personal dotfiles for my web design and front-end development
environment. I've borrowed heavily from [Mathias Bynens's
dotfiles](https://github.com/mathiasbynens/dotfiles), but instead of
installing locally, I link all files from the repo, allowing me to manage and
commit from the same location.

## Installation

Clone the files into your home directory:

    git clone git://github.com/nathanlong/dotfiles.git ~/.dotfiles

`cd` into the dotfile directory and run the coupler

    ./coupler.sh

This will initialize all submodules and create symlinks for all relevant
files. It will overwrite any files that already exist, so be aware!

Note: If you move the repo from `~/.dotfiles` you will need to change the file
sourcing in `.bash_profile`.

## Secret Places For Your Secrets

Need to add machine specific settings? I know I do. So there are a few places
I source for extra settings:

For bash:

    ~/.extra

Anything here will be sourced by the `.bash_profile`

For git:

    ~/.gitsecrets

Anything here will be sourced by `.gitconfig`. (Requires git version 1.7.10+).

Note: I use the new git credential checker that stores your github info
in the osx keychain when using the https protocol. Visit the github help pages
to make sure you're set up for that. Check for it on your machine by running:

    git credential-osxkeychain

If that comes back with an error, you need to install the credential checker!

## OSX Defaults

When setting up a new machine, run:

    ./.osx

This will set up some system defaults. For many more options check out Mathias
Bynens's [.osx file](https://github.com/mathiasbynens/dotfiles/blob/master/.osx).

## Additional Files for Vim

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


## A Note on Updating Vim Submodules

With git submodules, if `git submodule update` does not update your
submodules after you've checked them out, try:

    git submodule foreach git pull origin master
    git submodule update

(If you use command-t, you'll have to rebuild it after an update with `rake
make`.)
