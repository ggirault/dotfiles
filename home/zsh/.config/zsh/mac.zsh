# zsh session

export SHELL_SESSIONS_DISABLE=1

# ZSH autosuggestion
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=063,underline'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# fast-syntax-hightlighting
source $HOMEBREW_PREFIX/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

if ! infocmp tmux > /dev/null 2>&1; then
  tic -ax "$ZDOTDIR"/alacritty.info
  tic -ax "$ZDOTDIR"/tmux.info
fi
