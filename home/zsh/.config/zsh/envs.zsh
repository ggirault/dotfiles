# global system

export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'

export DOTFILES="$HOME/.dotfiles"

# homebrew
OS="$(uname)"
UNAME_MACHINE="$(/usr/bin/uname -m)"
if [[ $OS == "Darwin" ]] then
    if [[ $UNAME_MACHINE == "arm64" ]] then
        HOMEBREW_PREFIX="/opt/homebrew"
    else
        HOMEBREW_PREFIX="/usr/local"
    fi
fi
eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS="--appdir='$HOME/Applications' --fontdir='~/Library/Fonts' --require-sha --no-quarantine"
export HOMEBREW_BAT=1
#export HOMEBREW_BAT_THEME=

# zsh
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
mkdir -p $ZSH_CACHE_DIR
export ZSH_COMPDUMP="$ZSH_CACHE_DIR/zcompdump"
typeset -g HISTFILE="$ZSH_CACHE_DIR/zsh_history"
typeset -g HIST_STAMPS="yyyy-mm-dd"
typeset -g SAVEHIST=1000000
typeset -g HISTSIZE=$(( 1.2 * SAVEHIST ))

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
FZF_FILE_PREVIEW="([[ -f {} ]] && (bat --style=numbers --color=always --line-range :500 -- {} || cat {}))"
FZF_DIR_PREVIEW="([[ -d  {} ]] && (tree -C {} | less))"

export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden"
# default options
export FZF_DEFAULT_OPTS="
--height 70%
--border=rounded
--info=inline
--multi
--cycle
--preview-window=:nohidden:wrap,right:60%,border-bold
--preview '($FZF_FILE_PREVIEW || $FZF_DIR_PREVIEW) 2>/dev/null | head -200'
--prompt='∼ ' --pointer='▶' --marker='✓' 
--color=hl+:#ff00ff,bg:#292924,preview-bg:#34342f
--bind '?:toggle-preview,alt-w:toggle-preview-wrap' 
--bind 'ctrl-a:select-all' 
--bind 'ctrl-t:toggle-all'
--bind 'ctrl-s:toggle-sort'
--bind 'alt-c:deselect-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o $EDITOR)'
--bind 'ctrl-v:execute(code {+})'
--bind 'pgup:half-page-up'
--bind 'pgdn:half-page-down'
--bind 'shift-up:preview-page-up'
--bind 'shift-down:preview-page-down'
"
# CTRL-T command
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# CTRL-T's options
export FZF_CTRL_T_OPTS=" 
--preview-window=60% 
--prompt 'All> ' 
--header 'CTRL-D: Directories / CTRL-F: Files' 
--bind 'ctrl-d:change-prompt(Directories> )+reload($FZF_DEFAULT_COMMAND --sort-files --null | xargs -0 dirname | sort -u)' 
--bind 'ctrl-f:change-prompt(Files> )+reload($FZF_DEFAULT_COMMAND)' 
"
export FZF_ALT_C_COMMAND="fd --no-ignore --hidden --follow --strip-cwd-prefix --exclude '.git' --exclude '.venv*/' --type d"
# ALT-C's options
export FZF_ALT_C_OPTS="--prompt 'Directories> ' --preview '$FZF_DIR_PREVIEW' --preview-window=down,60%"
# CTRL-R's options
export FZF_CTRL_R_OPTS="--layout=default --preview-window=down,3,:hidden:wrap"

# ZSH Autosugggestion
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=063,underline'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Fast-syntax-hightlighting
source $HOMEBREW_PREFIX/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

#export SHELL_SESSIONS_DISABLE=1
export FORGIT_DIFF_PAGER="delta --width \$FZF_PREVIEW_COLUMNS"
