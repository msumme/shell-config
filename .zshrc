for x in `ls $HOME/.shell.d/*.{sh,zsh}`; do
  source "$x"
done
