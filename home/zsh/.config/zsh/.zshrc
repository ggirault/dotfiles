# This file is sourced by zsh when starting a new shell.
# See also: .zprofile, man 1 zsh

# zsh profiling
#zmodload zsh/zprof

# zsh
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
mkdir -p $ZSH_CACHE_DIR
export ZSH_COMPDUMP="$ZSH_CACHE_DIR/zcompdump"

typeset -g HISTFILE="$ZSH_CACHE_DIR/zsh_history"
typeset -g HIST_STAMPS="yyyy-mm-dd"
typeset -g SAVEHIST=1000000
typeset -g HISTSIZE=$(( 1.2 * SAVEHIST ))
HISTORY_IGNORE="(builtin *|exit|ls|r|open|pwd|q|x *|s *)"

setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word
setopt auto_menu                # show completion menu on successive tab press
setopt complete_in_word         # allow completion from within a word/phrase
setopt hash_list_all            # when a completion is attempted, hash it first
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.
setopt no_menu_complete         # no autoselect of the first completion entry
setopt no_flow_control          # disable start (C-s) and stop (C-q) characters
setopt globdots                 # match hidden files without explicitly specifying the dot
setopt extendedglob
#setopt ignore_eof               # prevent accidental C-d from exiting shell
setopt interactive_comments     # allow comments even in interactive shells
setopt auto_param_slash         # tab completing directory appends a slash
setopt auto_cd                  # .. is shortcut for cd .. (etc)
setopt auto_pushd               # make cd push the old directory onto the directory stack
setopt pushd_ignore_dups        # no duplicates in dir stack
setopt pushd_minus              # exchanges the meanings of ‘+’ and ‘-’ when used with a number to specify a directory in the stack
setopt pushd_silent             # no dir stack after pushd or popd
setopt append_history           # append to history
setopt extended_history         # write the history file in the ":start:elapsed;command" format
setopt inc_append_history       # write to the history file immediately, not when the shell exits
setopt share_history            # share history across multiple zsh sessions
setopt hist_expire_dups_first   # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_find_no_dups        # ignore duplicates when searching history
setopt hist_ignore_dups         # collapse two consecutive idential commands
setopt hist_ignore_space        # lines that begin with space are not recorded
setopt hist_reduce_blanks       # remove superfluous blanks before recording entry
setopt hist_verify              # confirm history expansion (!$, !!, !foo)
setopt no_hist_ignore_all_dups  # if a history entry would be duplicate, delete older copies
setopt multios                  # enable redirect to multiple streams: echo >file1 >file2
setopt long_list_jobs           # show long list format job notifications
setopt interactivecomments      # recognize comments

# Convenience aliases =========================================================

# zsh
alias reload!='source $ZDOTDIR/.zshrc'
alias less='zless'

# suffixes
alias -s log='tail -f'

# directory
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

# List directory contents
alias ls='ls -G'
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
alias ls-sort-time='ls -tlFh'
alias ls-sort-type='ls -SlFh'

# ssh
alias ssh='TERM=screen-256color ssh'

# git
alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdup='git diff @{upstream}'
alias gdw='git diff --word-diff'
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias glols="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat"
alias glod="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'"
alias glods="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all"
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias gst='git status'

# vim
alias vi="nvim"
alias oldvim="\vi"

# Airport
alias airport='sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport'
# Flush out the DNS Cache
alias flushDNS='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
# Opens current directory in MacOS Finder
alias finder='open -a Finder ./'
# Recursively delete .DS_Store files
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"
# Show top 10 commands
alias topcommands='print -l -- ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

# Additional shell settings (not zsh-specific) ================================

# Default terminal editor
export EDITOR=nvim
export VISUAL=nvim

# bat highlights some languages. -p (plain) skips borders and line numbers.
export PAGER="bat -p"

# -R sends control characters so it renders colours and bold and stuff.
# -X avoids clearing the screen.
export LESS="-RX --mouse --ignore-case --chop-long-lines --raw-control-chars --long-prompt --line-numbers --hilite-search"

# Shell plugins ===============================================================

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS="--appdir='$HOME/Applications' --fontdir='~/Library/Fonts' --require-sha --no-quarantine"
export HOMEBREW_BAT=1
export FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# starship
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
export STARSHIP_CACHE="$XDG_CACHE_HOME/starship"
eval "$(starship init zsh)"

# tty
if ! infocmp tmux > /dev/null 2>&1; then
  tic -ax "$ZDOTDIR"/alacritty.info
  tic -ax "$ZDOTDIR"/tmux.info
fi

# ripgrep
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/ripgreprc"

# fzf
FZF_FILE_PREVIEW="([[ -f {} ]] && (bat --style=numbers --color=always --line-range :500 -- {} || cat {}))"
FZF_DIR_PREVIEW="([[ -d  {} ]] && (tree -C {} | less))"

export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --glob \"!.git\""
export FZF_DEFAULT_OPTS="
--height 70%
--border=rounded
--exact
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
--bind 'pgup:preview-page-up'
--bind 'pgdn:preview-page-down'
--bind 'shift-up:preview-page-up'
--bind 'shift-down:preview-page-down'
"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
--preview-window=60%
--prompt 'All> '
--header 'CTRL-D: Directories / CTRL-F: Files'
--bind 'ctrl-d:change-prompt(Directories> )+reload($FZF_DEFAULT_COMMAND --sort-files --null | xargs -0 dirname | sort -u)'
--bind 'ctrl-f:change-prompt(Files> )+reload($FZF_DEFAULT_COMMAND)'
"
export FZF_ALT_C_COMMAND="fd --no-ignore --hidden --follow --strip-cwd-prefix --exclude '.git' --exclude '.venv*/' --type d"
export FZF_ALT_C_OPTS="--prompt 'Directories> ' --preview '$FZF_DIR_PREVIEW' --preview-window=down,60%"
export FZF_CTRL_R_OPTS="--layout=default --preview-window=down,3,:hidden:wrap"

# ZSH Autosugggestion
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=241'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
#ZSH_AUTOSUGGEST_MANUAL_REBIND=disabled

# Fast-syntax-hightlighting
source $HOMEBREW_PREFIX/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# ls colours ==================================================================
# I've no idea where these come from, but they look good. This variabls is used
# below for zsh's tab-completion, but not really by ls, since ls doesn't use
# colours by default.
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

# Autocompletion ==============================================================

# Must be loaded before compinit. Offer the ability to highlight matches in such a list, the ability to scroll through long lists and a different style of menu completion
zmodload -i zsh/complist
autoload -Uz compinit
# Disable compaudit temporarily
#ZSH_DISABLE_COMPFIX=true
# Function to regenerate .zcompdump if it's older than 7 days
regen_zcompdump() {
  local dumpfile="${ZSH_COMPDUMP}"
  if [[ -n "${dumpfile}"(#qN.md+7) ]]; then
    compinit -w -d "${dumpfile}"
    compdump
  else
    compinit -C
  fi
}
regen_zcompdump
# Re-enable compaudit after regenerating .zcompdump
#unset ZSH_DISABLE_COMPFIX

# Allow you to select in a menu
zstyle ':completion:*' menu select
# Colors for all completions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
autoload -Uz colors && colors
# Messages/warnings format
zstyle ':completion:*' verbose true
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format '%F{yellow}-- %D %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:default' select-prompt '%SScrolling active: current selection at %p%s'
# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''
# Use cache for command using cache
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$ZSH_CACHE_DIR/completions"
mkdir -p "${ZSH_CACHE_DIR}/completions"
# Make completion match at any part of the string (not just the beginning).
# (Note this isn't fuzzy though; it looks for an exact match).
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
# Don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'
# ignore uninteresting hosts
zstyle ':completion:*:*:*:hosts' ignored-patterns \
    localhost loopback ip6-localhost ip6-loopback localhost6 localhost6.localdomain6 localhost.localdomain
# Expand alias
zle -C alias-expension complete-word _generic
zstyle ':completion:alias-expension:*' completer _expand_alias

# Move over and edit words in the manner of bash
zstyle ':zle:*' word-style standard
WORDCHARS="[[:alpha:]0-9]"

# load bashcompinit for some old bash completions
autoload -U +X bashcompinit && bashcompinit

# Functions ===================================================================

# Create a new directory and enter it
mkd() {
	mkdir -p "$@"
	cd "$@" || exit
}

# Make a temporary directory and enter it
tmpd() {
	local dir
	if [ $# -eq 0 ]; then
		dir=$(mktemp -d)
	else
		dir=$(mktemp -d -t "${1}.XXXXXXXXXX")
	fi
	cd "$dir" || exit
}
# Start an HTTP server from a directory, optionally specifying the port
server() {
	local port="${1:-8000}"
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
getcertnames() {
	if [ -z "${1}" ]; then
		echo "ERROR: No domain specified."
		return 1
	fi

	local domain="${1}"
	echo "Testing ${domain}…"
	echo ""; # newline

	local tmp
	tmp=$(echo -e "GET / HTTP/1.0\\nEOT" \
		| openssl s_client -connect "${domain}:443" 2>&1)

	if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
		local certText
		certText=$(echo "${tmp}" \
			| openssl x509 -text -certopt "no_header, no_serial, no_version, \
			no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux")
		echo "Common Name:"
		echo ""; # newline
		echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//"
		echo ""; # newline
		echo "Subject Alternative Name(s):"
		echo ""; # newline
		echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
			| sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\\n" | tail -n +2
		return 0
	else
		echo "ERROR: Certificate not found."
		return 1
	fi
}

# Extract most know archives with one command
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
       esac
   else
       echo "'$1' is not a valid file"
   fi
}

# Linux specific aliases, work on both MacOS and Linux.
#pbcopy() {
#	stdin=$(</dev/stdin);
#	pbcopy="$(which pbcopy)";
#	if [[ -n "$pbcopy" ]]; then
#		echo "$stdin" | "$pbcopy"
#	else
#		echo "$stdin" | xclip -selection clipboard
#	fi
#}
pbpaste() {
	pbpaste="$(which pbpaste)";
	if [[ -n "$pbpaste" ]]; then
		"$pbpaste"
	else
		xclip -selection clipboard
	fi
}

# Keybindings =================================================================

# Setting EDITOR will change ZSH default behavior. Switch zsh bindings back to
# emacs key binding
bindkey -e

# Scroll instead of clearing with Ctrl+L.
# See: https://codeberg.org/dnkl/foot/wiki#how-do-i-make-ctrl-l-scroll-the-content-instead-of-erasing-it
if [[ $TERM =~ "^foot" ]]; then
    clear-screen-keep-sb() {print -rn ${(pl:LINES-BUFFERLINES::\n:)}; zle .clear-screen}
    zle -N clear-screen clear-screen-keep-sb
fi

typeset -gA keys=(
    F1                   '^[OP'
    F2                   '^[OQ'
    F3                   '^[OR'
    F4                   '^[OS'
    F5                   '^[[15~'
    F6                   '^[[17~'
    F7                   '^[[18~'
    F8                   '^[[19~'
    F9                   '^[[20~'
    F10                  '^[[21~'
    F11                  '^[[23~'
    F12                  '^[[24~'

    Esc                  '\e'
    Up                   '^[[A'
    Down                 '^[[B'
    Right                '^[[C'
    Left                 '^[[D'
    Home                 '^[[1~'
    End                  '^[[4~'
    Insert               '^[[2~'
    Delete               '^[[3~'
    PageUp               '^[[5~'
    PageDown             '^[[6~'
    Backspace            '^?'

    Shift+Up             '^[[1;2A'
    Shift+Down           '^[[1;2B'
    Shift+Right          '^[[1;2C'
    Shift+Left           '^[[1;2D'
    Shift+End            '^[[1;2F'
    Shift+Home           '^[[1;2H'
    Shift+Insert         '^[[2;2~'
    Shift+Delete         '^[[3;2~'
    Shift+PageUp         '^[[5;2~'
    Shift+PageDown       '^[[6;2~'
    Shift+Backspace      '^?'
    Shift+Tab            '^[[Z'

    Alt+Up               '^[[1;3A'
    Alt+Down             '^[[1;3B'
    Alt+Right            '^[[1;3C'
    Alt+Left             '^[[1;3D'
    Alt+End              '^[[1;3F'
    Alt+Home             '^[[1;3H'
    Alt+Insert           '^[[2;3~'
    Alt+Delete           '^[[3;3~'
    Alt+PageUp           '^[[5;3~'
    Alt+PageDown         '^[[6;3~'
    Alt+Backspace        '^[^?'

    Alt+Shift+Up         '^[[1;4A'
    Alt+Shift+Down       '^[[1;4B'
    Alt+Shift+Right      '^[[1;4C'
    Alt+Shift+Left       '^[[1;4D'
    Alt+Shift+End        '^[[1;4F'
    Alt+Shift+Home       '^[[1;4H'
    Alt+Shift+Insert     '^[[2;4~'
    Alt+Shift+Delete     '^[[3;4~'
    Alt+Shift+PageUp     '^[[5;4~'
    Alt+Shift+PageDown   '^[[6;4~'
    Alt+Shift+Backspace  '^[^H'

    Ctrl+Up              '^[[1;5A'
    Ctrl+Down            '^[[1;5B'
    Ctrl+Right           '^[[1;5C'
    Ctrl+Left            '^[[1;5D'
    Ctrl+Home            '^[[1;5H'
    Ctrl+End             '^[[1;5F'
    Ctrl+Insert          '^[[2;5~'
    Ctrl+Delete          '^[[3;5~'
    Ctrl+PageUp          '^[[5;5~'
    Ctrl+PageDown        '^[[6;5~'
    Ctrl+Backspace       '^H'

    Ctrl+Shift+Up        '^[[1;6A'
    Ctrl+Shift+Down      '^[[1;6B'
    Ctrl+Shift+Right     '^[[1;6C'
    Ctrl+Shift+Left      '^[[1;6D'
    Ctrl+Shift+Home      '^[[1;6H'
    Ctrl+Shift+End       '^[[1;6F'
    Ctrl+Shift+Insert    '^[[2;6~'
    Ctrl+Shift+Delete    '^[[3;6~'
    Ctrl+Shift+PageUp    '^[[5;6~'
    Ctrl+Shift+PageDown  '^[[6;6~'
    Ctrl+Shift+Backspace '^?'

    Ctrl+Alt+Up          '^[[1;7A'
    Ctrl+Alt+Down        '^[[1;7B'
    Ctrl+Alt+Right       '^[[1;7C'
    Ctrl+Alt+Left        '^[[1;7D'
    Ctrl+Alt+Home        '^[[1;7H'
    Ctrl+Alt+End         '^[[1;7F'
    Ctrl+Alt+Insert      '^[[2;7~'
    Ctrl+Alt+Delete      '^[[3;7~'
    Ctrl+Alt+PageUp      '^[[5;7~'
    Ctrl+Alt+PageDown    '^[[6;7~'
    Ctrl+Alt+Backspace   '^[^H'

    Ctrl+Alt+Shift+Up        '^[[1;8A'
    Ctrl+Alt+Shift+Down      '^[[1;8B'
    Ctrl+Alt+Shift+Right     '^[[1;8C'
    Ctrl+Alt+Shift+Left      '^[[1;8D'
    Ctrl+Alt+Shift+Home      '^[[1;8H'
    Ctrl+Alt+Shift+End       '^[[1;8F'
    Ctrl+Alt+Shift+Insert    '^[[2;8~'
    Ctrl+Alt+Shift+Delete    '^[[3;8~'
    Ctrl+Alt+Shift+PageUp    '^[[5;8~'
    Ctrl+Alt+Shift+PageDown  '^[[6;8~'
    Ctrl+Alt+Shift+Backspace '^?'
)

# source: https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/key-bindings.zsh
# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

# https://sgeb.io/posts/zsh-zle-custom-widgets/
# Test a widget interactively: execute-named-cmd (Alt-x)
# List all widgets: zsl -la
bindkey -- "^Hc" describe-key-briefly
bindkey -- "${keys[Home]}"             beginning-of-line
bindkey -- "${keys[End]}"              end-of-line
bindkey -- "${keys[Backspace]}"        backward-delete-char
#bindkey -- "${keys[Insert]}"           overwrite-mode
bindkey -- "${keys[Delete]}"           delete-char
#bindkey -- "${keys[Left]}"             backward-char
#bindkey -- "${keys[Right]}"            forward-char
#bindkey -- "${keys[PageUp]}"           up-line-or-history
#bindkey -- "${keys[PageDown]}"         down-line-or-history
#bindkey -- "${keys[Ctrl+Left]}"        backward-word
#bindkey -- "${keys[Ctrl+Right]}"       forward-word
#bindkey -- "${keys[Ctrl+Delete]}"      kill-word
bindkey -- "${keys[Alt+Left]}"         backward-word
bindkey -- "${keys[Alt+Right]}"        forward-word
bindkey -- "${keys[Alt+Up]}"           up-line-or-history
bindkey -- "${keys[Alt+Down]}"         down-line-or-history
bindkey -- "${keys[Alt+Delete]}"       kill-word
bindkey -- "${keys[Shift+Tab]}"        reverse-menu-complete
#bindkey '^[w' kill-region                             # [C-w] - Kill from the cursor to the mark
bindkey -M menuselect "${keys[Esc]}"      send-break      # quit completion on escape
bindkey -M menuselect "${keys[PageUp]}"   backward-word # Scroll page up
bindkey -M menuselect "${keys[PageDown]}" forward-word  # Scroll page down
bindkey -- "^Xa" _expand_alias
bindkey -- "^X?" _complete_debug

# Optional config =============================================================

if [[ -e "$HOME/.zshrc_local" ]]; then
  source "$HOME/.zshrc_local"
fi

# Additional Library ==========================================================

# Load all of the config files in lib/ that end in .zsh
# TIP: Add files you don't want in git to .gitignore
for config_file ("$ZDOTDIR"/lib/*.zsh); do
  custom_config_file="$ZSH_CUSTOM/lib/${config_file:t}"
  [[ -f "$custom_config_file" ]] && config_file="$custom_config_file"
  source "$config_file"
done
unset custom_config_file

# zsh profiling
#zprof