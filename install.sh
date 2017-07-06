#!/usr/bin/env bash

set -e -u

dir="$HOME/shell-config-git"

if [[ ! -d "$dir" ]]; then
    git clone git@github.com:msumme/shell-config.git "$dir"
fi

function warning() {
    local file="$1"
     echo "Your $file will be overwritten.  Ctrl-C to abort, any key to continue"
    read
}

for file in $dir/.*rc; do
    last=${file##*/}
    echo $last
    if [[ -e "$HOME/$last" ]];then
        warning "$last"
        mv "$HOME/$last" "$HOME/$last.bk"
    fi
    ln -sf "$dir/$last" "$HOME/$last"
done

#TODO - make a directory and then symlink everything together by default
# but this way we don't actually overwrite the .shell.d at all - we just install our own.

if [[ ! -d "$HOME/.shell.d" ]]; then
    mkdir -p "$HOME/.shell.d"
fi

for file in $dir/.shell.d/*; do
    last=${file##*/}
    if [[ -e "$HOME/.shell.d/$last" ]];then
        warning ".shell.d/$last"
        mv "$HOME/.shell.d/$last" "$HOME/.shell.d/$last.bk"
    fi
    ln -sf "$dir/.shell.d/$last" "$HOME/.shell.d/$last"
done

