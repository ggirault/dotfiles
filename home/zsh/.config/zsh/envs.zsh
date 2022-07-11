# global system

export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

export DOTFILES="$HOME/.dotfiles"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS="--appdir='$HOME/Applications' --require-sha"

# zsh
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump"
export HISTFILE="$XDG_CACHE_HOME/zsh/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=9000

# editor
if [[ -n "${commands[nvim]}" ]]; then
  export EDITOR"=nvim"
elif [[ -n "${commands[vim]}" ]]; then
  export EDITOR="vim"
else
  export EDITOR="vi"
fi
export USE_EDITOR="$EDITOR"
export VISUAL="$EDITOR"

# Man pages
export MANPAGER='nvim +Man!'

# pager
less_options=(
    # Like "smartcase" in Vim: ignore case unless the search
    --ignore-case
    # Do not automatically wrap long lines.
    --chop-long-lines
    # Allow ANSI colour escapes, but no other escapes.
    --RAW-CONTROL-CHARS
    # Causes less to prompt event more verbosely than more
    --LONG-PROMPT
    # Supresses line numbers
    --line-numbers
    # Highlight only the particular string
    --hilite-search
    # Disable termcap initialization
    --no-init
    # Enables scrolling with the mouse wheel
    --mouse
    --wheel-lines=3
);
export LESS="${less_options[*]}"
export LESSHISTFILE="$XDG_CACHE_HOME/lesshst"
export LESSSECURE=1
export PAGER=less

# ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"

# fzf
export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude '.git'"
# default options
export FZF_DEFAULT_OPTS=" \
--border \
--info=inline \
--multi \
--preview-window=:nohidden:wrap \
--preview '([[ -f {} ]] && (bat --style=numbers --color=always --line-range :500 {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200' \
--prompt='∼ ' --pointer='▶' --marker='✓' \
--color=hl+:#ff00ff,preview-bg:#292924 \
--bind '?:toggle-preview' \
--bind 'ctrl-a:select-all' \
--bind 'ctrl-t:toggle-all' \
--bind 'alt-c:deselect-all' \
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)' \
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)' \
--bind 'ctrl-v:execute(code {+})' \
--bind 'pgup:half-page-up' \
--bind 'pgdn:half-page-down' \
--bind 'shift-up:preview-page-up' \
--bind 'shift-down:preview-page-down' \
"
# CTRL-T's options
export FZF_CTRL_T_OPTS=" \
--preview-window=60% \
--prompt 'All> ' \
--header 'CTRL-D: Directories / CTRL-F: Files' \
--bind 'ctrl-d:change-prompt(Directories> )+reload($FZF_DEFAULT_COMMAND --type d)' \
--bind 'ctrl-f:change-prompt(Files> )+reload($FZF_DEFAULT_COMMAND --type f --type e --type l)' \
"
# ALT-C's options
export FZF_ALT_C_OPTS="--prompt 'Directories> ' --preview-window=down,80%"
# CTRL-R's options
export FZF_CTRL_R_OPTS="--layout=default --preview-window=down,3,:nohidden:wrap"
