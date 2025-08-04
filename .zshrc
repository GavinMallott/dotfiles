# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/usr/sbin:$PATH

export ZVM_ACTIVE=1
export ZIG_VERSION="$(zig version)"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.config/.oh-my-zsh"

plugins=(git zvm)

ZSH_THEME="gavin"

source $ZSH/oh-my-zsh.sh

alias la="ls -al"
alias clera="clear"
alias sourcez="source ~/.zshrc"
alias zshrc="nvim ~/.zshrc"
alias vim="nvim"
alias vimrc="nvim ~/.config/nvim/init.lua"
