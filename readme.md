# Dotfiles

### AKA VIMTASTIC FRONT END DEVELOPMENT SETTINGS

## Installation

Clone the files into your home directory:

    git clone git://github.com/nathanlong/dotfiles.git ~/.dotfiles

`cd` into the dotfile directory and run the coupler

    ./coupler.sh

This will initialize all submodules and create symlinks for all relevant
files. It will overwrite any files that already exist, so... fair warning!

**Note:** If you move the repo from `~/.dotfiles` you will need to change the file
sourcing in `.bash_profile`.

## Local Overrides

For quick settings, or environment specific settings use the following files,
all are sourced by default.

Bash = `~/.extra`

Vim = `~/.vimrc.local`

Git = `~/.gitconfig.local`

**Note:** The `coupler.sh` will create a blank `.vimrc.local` in your home dir
by default so that Vim doesn't get all mad and throw a fit when it can't find
it.

## Extra Folders and Bookmarks for Vim

I keep Vim's persistent undo and plugin support files in a directory called
`tmp` that sits inside the `.vim` directory. `coupler.sh` will create this
directory for you.

I also keep a file called `vimbookmarks` in that directory that allows me to
quickly navigate to projects. I use the leader key plus a number to store my
current project directories. Something like: 

    map <leader>1 :cd /path/to/directory1/<cr>
    map <leader>2 :cd /path/to/directory2/<cr>
    
I also map quick editing shortcuts to the file, so I can change bookmarks
quickly when I need to.

    map <leader>9 :15sp ~/.vim/tmp/vimbookmarks<cr>

## A Note on Updating Submodules

It seems that cloning this repo will create detached heads for all submodules
(does not check out a branch, just floats at a specific commit).  If that's
ok, then just leave it as is. 

But, if you'd like to continually update your submodules run:

    git submodule foreach git checkout master

Which will switch them all to the master branch. An update can be run as:

    git submodule foreach git pull

These commands are also aliased as `git small` and `git smp` respectively.

## OSX Defaults

When setting up a new machine, cd into the dotfiles repo and run:

    ./.osx

This will set up some handy dandy system defaults. For many more options check
out Mathias Bynens's [.osx file](https://github.com/mathiasbynens/dotfiles/blob/master/.osx).

