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

# Find in file
fif () {
    if [ ! "$#" -gt 0 ]
    then
        echo "Need a string to search for!"
        return 1
    fi
    rg --files-with-matches --hidden --no-ignore --glob="!.git/" --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' {}"
}
