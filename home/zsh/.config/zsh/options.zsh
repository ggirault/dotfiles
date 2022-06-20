unsetopt menu_complete          # do not autoselect the first completion entry
unsetopt flowcontrol            # disable start (C-s) and stop (C-q) characters
setopt hash_list_all            # hash everything before completion
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word    
setopt auto_menu                # show completion menu on successive tab press
setopt complete_in_word         # allow completion from within a word/phrase
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.

setopt auto_param_slash         # tab completing directory appends a slash
#setopt ignore_eof               # prevent accidental C-d from exiting shell
setopt interactive_comments     # allow comments even in interactive shells

setopt auto_cd                  # .. is shortcut for cd .. (etc)
setopt auto_pushd               # make cd push the old directory onto the directory stack
setopt pushd_ignore_dups        # no duplicates in dir stack
setopt pushd_minus              # exchanges the meanings of ‘+’ and ‘-’ when used with a number to specify a directory in the stack
setopt pushd_silent             # no dir stack after pushd or popd

setopt longlistjobs             # print job notifications in the long format by default
#setopt print_exit_value         # print return value if non-zero

## History command configuration
setopt share_history            # share history across multiple zsh sessions
setopt append_history           # append to history
setopt extended_history         # record timestamp of command in HISTFILE
setopt hist_expire_dups_first   # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups         # ignore duplicated commands history list
setopt hist_ignore_space        # ignore commands that start with space
setopt hist_verify              # confirm history expansion (!$, !!, !foo)
setopt share_history            # share command history data
setopt hist_reduce_blanks       # trim blanks
setopt no_hist_ignore_all_dups  # do not remove older command from the list
