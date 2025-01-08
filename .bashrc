#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vi='nvim'
alias g='git'
alias gst='git status'
alias manls="man -k . | fzf | awk '{print $1}' | xargs man"
alias manll='man -k . | fzf | awk "{print $1}" | xargs -r man'
alias fzf='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias nf='nvim -o `fzf --preview "less {}"`'
alias cat='bat --paging=never'
alias tail='tail -f $1 | bat --paging=never -l log'

PS1='[\u@\h \W]\$ '

. /usr/share/z/z.sh

export PATH=/usr/lib/node_modules/corepack/shims:$PATH
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
export PATH=/home/otsu/.local/bin:$PATH
export PATH=/home/otsu/github/nvim/bin/:$PATH

export RAILS="/home/otsu/.local/share/gem/ruby/3.3.0/gems/railties-8.0.0/exe"
export PATH="$PATH:$RAILS"

# export PATH=/home/otsu/.local/share/gem/ruby/3.3.0/bin:$PATH
#export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# set up help pages with syntax highlight
# in your .bashrc/.zshrc/*rc
# alias bathelp='bat --plain --language=help'
# help() {
#     "$@" --help 2>&1 | bathelp
# }

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

eval "$(fzf --bash)"
#eval "$(starship init bash)"
export PATH=~/.local/bin:"$PATH"
export GEM_HOME=$HOME/.gem
