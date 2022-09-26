#fpath+="${0:A:h}/plugins/zsh-completions/src"

if command -v brew > /dev/null 2>&1; then
    fpath=("$HOMEBREW_PREFIX/share/zsh-completions" $fpath)
fi

zmodload -i zsh/complist

# Enable regex moving
autoload -U zmv

# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# auto rehash commands
# http://www.zsh.org/mla/users/2011/msg00531.html
zstyle ':completion:*' rehash true

# Define completers
zstyle ':completion:*' completer _complete _prefix _ignored
#zstyle ':completion:*' completer _complete _match _prefix _correct

zstyle ':completion:*:prefix-complete:*' completer _complete
# Configure the match completer, more flexible of GLOB_COMPLETE
# with original set to only it doesn't act like a `*' was inserted at the cursor position
#zstyle ':completion:*:match:*' original only
# Correction will accept up to one error. If a numeric argument is given, correction will not be performed
zstyle ':completion:*:correct:*' max-errors 1 not-numeric
#zstyle ':completion:*:prefix-approximate:*' completer _approximate

zstyle '*' single-ignored show

# First case insensitive completion, then case-sensitive partial-word completion, then case-insensitive partial-word completion
# (with -_. as possible anchors)
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[-_.]=* r:|=*' 'm:{a-z}={A-Z} r:|[-_.]=* r:|=*'
# First case insensitive completion, then case-sensitive partial-word completion (word*), then case-insensitive partial-word completion (WoRd*)
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'm:{a-zA-Z}={A-Za-z} r:|=*'

# First case insensitive completion (when in lowercase but not the opposite)
# then case-sensitive partial-word completion (word*)
# then case sensitive partial-word completion (*word)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|=*' 'l:|=*'

# Allow 2 errors in correct completer
zstyle ':completion:*:correct:*' max-errors 2 not-numeric

# Menu selection
zstyle ':completion:*' menu select # Allow you to select in a menu

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
# Scroll completion list by half-screenfuls
zstyle ':completion:*:default' select-scroll 0
# Generate description with magic
zstyle ':completion:*' auto-description 'specify: %d'
# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''
#zstyle ':completion:*:matches' group 'yes' # Separate matches into groups
# Show message while waiting for completion
#zstyle ':completion:*' show-completer true

# Smart completion of . and ..
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'

# Use cache for commands using cache
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$ZSH_CACHE_DIR"

# Display order of commands
zstyle ':completion:*:*:-command-:*:*' group-order aliases functions commands builtins

# Group manpages manual.X
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*:man:*' menu yes select

# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USERNAME -o pid,user,args -w -w'
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' insert-ids single
zstyle ':completion:*:*:killall:*' menu yes select

zstyle ':completion:*:*:git:*' tag-order common-commands

# Ignore completion functions for commands you don't have:
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec)|TRAP*)'
# Don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

#zstyle ':completion:*' file-sort modification reverse
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
# complete 'cd -<tab>' with menu
zstyle ':completion:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order named-directories path-directories users expand
# Do not assume multiple slashes mean multiple directories (fo//ba is fo/ba not fo/*/ba)
zstyle ':completion:*' squeeze-slashes true
# Try to keep a prefix containing a tilde or parameter expansion like ‘~/f*’ would be expanded to ‘~/foo’ instead of ‘/home/user/foo’
zstyle ':completion:*' keep-prefix true

# ignore uninteresting hosts
zstyle ':completion:*:*:*:hosts' ignored-patterns \
    localhost loopback ip6-localhost ip6-loopback localhost6 localhost6.localdomain6 localhost.localdomain

# Expand alias
zle -C alias-expension complete-word _generic
bindkey '^Xa' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

#zstyle -e ':completion:*:(ssh|scp|sftp|ssh-copy-id):*' hosts 'reply=(${(s: :)${${${(M)${(f)"$(<~/.ssh/config)"}:#Host*}#Host }:#*\**}} ${${${${(f)"$(<~/.ssh/known_hosts)"}:#[|0-9]*}%%\ *}%%,*} )'
#zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# Move over and edit words in the manner of bash
autoload -U select-word-style
select-word-style bash
# ... but don't stop on these characeters
zstyle ':zle:*' word-chars '.-'

# A newly added command will may not be found or will cause false
# correction attempts, if you got auto-correction set. By setting the
# following style, we force accept-line() to rehash, if it cannot
# find the first word on the command line in the $command[] hash.
zstyle ':acceptline:*' rehash true

#autoload -Uz compinit; compinit -D
autoload -Uz compinit
if [[ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' $ZSH_COMPDUMP) ]]; then
  compinit -i -d $ZSH_COMPDUMP
else
  compinit -C -i -d $ZSH_COMPDUMP
fi

# load bashcompinit for some old bash completions
autoload -U +X bashcompinit && bashcompinit
