# vimrc

## install vim-plug

[vim-plug](https://junegunn.github.io/vim-plug/) is a minimalist Vim plugin manager by Junegunn Choi.

- `mkdir -p .vim/plug/autoload`
- Get [plug.vim](https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim) in "autoload".

## install git

`scoop install git` on Windows, `brew install git` on MacOS.

## install ctags-win

On Windows, get [ctags-win](https://github.com/universal-ctags/ctags-win32/releases) in `$PATH` directory.

## get _vimrc in ~

Get _vimrc in `%HOMEDRIVE%\%HOMEPATH%` on Windows or `~/.vim` and `ln -s ~/.vim/_vimrc ~/.vimrc` on Linux or MacOS.

## install plugins

Run Vim and ex `:PlugInstall` to install all the plugins referred in _vimrc.

## credits

- [vimtweak](https://github.com/mattn/vimtweak)
- [vim-plug](https://junegunn.github.io/vim-plug/)
- [ctags-win](https://github.com/universal-ctags/ctags-win32/releases)
