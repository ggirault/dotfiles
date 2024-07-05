# This file is run by zsh only for login shells.
# See: https://zsh.sourceforge.io/Intro/intro_3.html
# See: man 1 zshall

# Set US spellings.
export LANG="en_US.UTF-8"
# Sort dotfiles, then uppercase, then lowercase:
export LC_COLLATE="C"
# Use ISO date format DD-MM-YYYY and 24h:
export LC_TIME="fr_FR.UTF-8"
# Currency in Euros:
export LC_MONETARY="fr_FR.UTF-8"
# Set numeric format to US:
export LC_NUMERIC="en_US.UTF-8"

export DOTFILES="$HOME/.dotfiles"

# State. Data that's nice to keep, but replaceable.
export CARGO_HOME=$XDG_STATE_HOME/cargo
export RUSTUP_HOME=$XDG_STATE_HOME/rustup
export WORKON_HOME=$XDG_DATA_HOME/virtualenvs

# Cache data. Perfectly fine to lose.
export npm_config_cache=$XDG_CACHE_HOME/npm
export GOPATH=$XDG_CACHE_HOME/golang

# Include my local bin dir and cargo's binaries in $PATH:
export PATH=$HOME/.local/bin:$CARGO_HOME/bin:$PATH

# Interactive shell histories:
export LESSHISTFILE=$XDG_DATA_HOME/less_history
export MANWIDTH=92

# Man pages
#export MANPAGER='nvim +Man!'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Make `pip` require a virtualenv (e.g.: don't use ~/.local/bin/)
export PIP_REQUIRE_VIRTUALENV=true
