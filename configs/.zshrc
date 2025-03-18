autoload -U promptinit; promptinit
prompt pure

eval "$(fzf --zsh)"
eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"

zstyle ':completion:*' menu no

alias ls="ls --color"
alias sv="cd ~/vault && git add . && git commit -m 'Manual Commit' && git push"

