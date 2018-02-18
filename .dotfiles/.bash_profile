for DOTFILE in `find /Users/christian/Documents/coding/repositories/dotfiles`
do
  [ -f "$DOTFILE" ] && source "$DOTFILE"
done