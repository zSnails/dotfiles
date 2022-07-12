#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='exa --icons'
alias vi='nvim'
alias vim='nvim'
alias tmux='tmux -u'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias xxd='hexdump -C'
alias grep='rg'
alias hx="helix"

# cat ~/.cache/wal/sequences
colorscript random

# eval "$(oh-my-posh completion bash)"
eval "$(oh-my-posh init bash --config ~/.poshthemes/material.omp.json)"

export PATH=~/go/bin:$PATH
export EDITOR="nvim"
export PATH=$PATH:/home/arbitrario/.spicetify
export GOBIN=$HOME/go/bin
taskr
