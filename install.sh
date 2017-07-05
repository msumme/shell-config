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
    fi
    ln -sf "$dir/$last" "$HOME/$last"
done

if [ -d "$HOME/.shell.d" ]; then
    warning ".shell.d"
    mv "$HOME/.shell.d" "$HOME/.shell.d.bk"
fi

ln -s "$dir/.shell.d" "$HOME/.shell.d"