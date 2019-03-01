# Bash aliases

# Navigational convenience
alias l="ls -al"
alias ..="cd .."
alias cd..="cd .."
alias c="clear"
alias back="cd - > /dev/null"

# Power.  MUCH better looking grep.
alias grep="grep -Hn --color=auto"
alias egrep="egrep -Hn --color=auto"
alias pgrep="pgrep -Hn --color=auto"

# My root and user bashrc files are linked to be the same.  This makes sure that the
# root rm / cp / mv commands are prompting.
if [[ $(id -u) -eq 0 ]]; then
    alias rm='rm -i'
    alias cp='cp -i'
    alias mv='mv -i'
fi

# Bash aliases
alias bashedit="subl -n ~/.bashrc"
alias update="source ~/.bashrc"

# Git aliases
alias gis="git status"
alias gia="git add"
alias giu="git add -u"
alias gic="git commit -m"
alias push="git push"
alias pull="git pull"
alias out="logout"
alias gid="git diff"
