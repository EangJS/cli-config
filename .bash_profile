alias ls='eza -l --icons'
alias cat='batcat'
eval "$(starship init bash)"
cd(){
    builtin cd "$@" && ls
}

