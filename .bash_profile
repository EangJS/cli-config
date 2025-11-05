alias ls='eza -l --icons'
alias bat='batcat'
eval "$(starship init bash)"
cd(){
    builtin cd "$@" && ls
}
# Make cursor a vertical line
echo -e '\e[6 q'
