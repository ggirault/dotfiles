# zsh profiling
#zmodload zsh/zprof

source "$ZDOTDIR/envs.zsh"

source "$ZDOTDIR/aliases.zsh"

source "$ZDOTDIR/options.zsh"

source "$ZDOTDIR/completion.zsh"

source "$ZDOTDIR/prompt.zsh"

source "$ZDOTDIR/functions.zsh"

source "$ZDOTDIR/key-bindings.zsh"

if [[ "$(uname -s)" == 'Linux' ]]; then
      source "$ZDOTDIR/linux.zsh"
  elif [[ "$(uname -s)" == 'Darwin' ]]; then
        source "$ZDOTDIR/mac.zsh"
fi

if [[ -e "$HOME/.zshrc_local" ]]; then
  source "$HOME/.zshrc_local"
fi

# Disable CTRL-S and CTRL-Q
# superseded by eunsetopt flowcontrol
#[[ $- =~ i ]] && stty -ixoff -ixon

# Load all of the config files in lib/ that end in .zsh
# TIP: Add files you don't want in git to .gitignore
for config_file ("$ZDOTDIR"/lib/*.zsh); do
  custom_config_file="$ZSH_CUSTOM/lib/${config_file:t}"
  [[ -f "$custom_config_file" ]] && config_file="$custom_config_file"
  source "$config_file"
done
unset custom_config_file

# Load all of your custom configurations from custom/
for config_file ("$ZSHDOTDIR"/custom/*.zsh(N)); do
  source "$config_file"
done
unset config_file

# zsh profiling
#zprof
