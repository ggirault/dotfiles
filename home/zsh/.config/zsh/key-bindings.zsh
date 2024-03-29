# Setting EDITOR will change ZSH default behavior. Switch zsh bindings back to
# emacs key binding
bindkey -e

# show all terminfo array:
# $ printf '%q => %q\n' "${(@kv)terminfo}"
#
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
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

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

bindkey -M menuselect "${keys[Esc]}"   send-break      # quit completion on escape
bindkey -M menuselect "${keys[PageUp]}"           backward-word # Scroll page up
bindkey -M menuselect "${keys[PageDown]}"         forward-word  # Scroll page down

bindkey -- "^Xa" _expand_alias
bindkey -- "^X?" _complete_debug

# fzf
join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
} f b t r h s
