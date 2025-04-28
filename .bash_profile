alias ls='eza -l --icons'
alias bat='batcat'
eval "$(starship init bash)"
cd(){
    builtin cd "$@" && ls
}

