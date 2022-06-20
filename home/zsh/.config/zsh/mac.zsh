# zsh session

export SHELL_SESSIONS_DISABLE=1

# ZSH autosuggestion
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#777,underline'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40
ZSH_AUTOSUGGEST_USE_ASYNC=1

# fast-syntax-hightlighting
source $(brew --prefix)/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

if ! infocmp $TERM > /dev/null 2>&1; then
  tic tmux.terminfo
fi
