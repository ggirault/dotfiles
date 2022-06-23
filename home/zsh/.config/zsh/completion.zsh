fpath=("$ZDOTDIR/plugins/zsh-completions/src" $fpath)

#autoload -Uz compinit; compinit -D
autoload -Uz compinit
if [[ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' $ZSH_COMPDUMP) ]]; then
  compinit -d $ZSH_COMPDUMP
else
  compinit -C -d $ZSH_COMPDUMP
fi

#_comp_options+=(globdots)       # with hidden files

zmodload zsh/complist

# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers
zstyle ':completion:*' completer _extensions _complete
# Allow you to select in a menu
zstyle ':completion:*:*:*:*:*' menu select
# Case sensitive (all), partial-word and substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
# Use cache for commands using cache
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

zstyle ':completion:*' verbose yes
# Colors for files and directory
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# Sort by modification date
zstyle ':completion:*' file-sort modification

zstyle ':completion:*:*:*:*:processes' command 'ps -u $USERNAME -o pid,user,comm -w -w'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always

# Group manpages manual.X
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# Disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Group results
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# Keep the string ‘~/f*’ would be expanded to ‘~/foo’ instead of ‘/home/user/foo’
zstyle ':completion:*' keep-prefix true

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

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

#compdef '_files -g "*.tgz *.gz *.tbz2 *.bz2 *.tar *.rar *.zip *.Z *.7z *.xz *.lzma *.lha *.rpm *.deb"' extract_archive
