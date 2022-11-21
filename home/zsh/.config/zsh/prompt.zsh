### Starship prompt

export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship"

eval "$(starship init zsh)"

# tty
if ! infocmp tmux > /dev/null 2>&1; then
  tic -ax "$ZDOTDIR"/alacritty.info
  tic -ax "$ZDOTDIR"/tmux.info
fi
