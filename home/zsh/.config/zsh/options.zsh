setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word    
setopt auto_menu                # show completion menu on successive tab press
setopt complete_in_word         # allow completion from within a word/phrase
setopt hash_list_all            # when a completion is attempted, hash it first
setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.
setopt no_menu_complete         # no autoselect of the first completion entry
setopt no_flow_control          # disable start (C-s) and stop (C-q) characters
setopt globdots                 # match hidden files without explicitly specifying the dot

#setopt ignore_eof               # prevent accidental C-d from exiting shell
setopt interactive_comments     # allow comments even in interactive shells

setopt auto_param_slash         # tab completing directory appends a slash
setopt auto_cd                  # .. is shortcut for cd .. (etc)
setopt auto_pushd               # make cd push the old directory onto the directory stack
setopt pushd_ignore_dups        # no duplicates in dir stack
setopt pushd_minus              # exchanges the meanings of ‘+’ and ‘-’ when used with a number to specify a directory in the stack
setopt pushd_silent             # no dir stack after pushd or popd

setopt long_list_jobs           # print job notifications in the long format by default
#setopt print_exit_value         # print return value if non-zero

## History command configuration
setopt append_history           # append to history
setopt extended_history         # write the history file in the ":start:elapsed;command" format
setopt inc_append_history       # write to the history file immediately, not when the shell exits
setopt share_history            # share history across multiple zsh sessions
setopt hist_expire_dups_first   # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_find_no_dups        # do not display an entry previously found
setopt hist_ignore_dups         # don't record an entry that was just recorded again
setopt hist_ignore_space        # don't record an entry starting with a space
setopt hist_reduce_blanks       # remove superfluous blanks before recording entry
setopt hist_verify              # confirm history expansion (!$, !!, !foo)
setopt no_hist_ignore_all_dups  # do not remove older command from the list
