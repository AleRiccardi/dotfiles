# =============================================================================
#  General
# =============================================================================
alias xopen='xdg-open'
alias xcopy='xclip -selection clipboard'
alias rmrf='rm -rf'
alias ag='ag -U'
alias du='du -sh'


# =============================================================================
#  Git
# =============================================================================
alias gs='git status'
alias gst='git status'
alias gc='git commit'
alias gco='git checkout'
alias gl='git pull'
alias gpom="git pull origin master"
alias gp='git push'
alias gd='git diff'
alias gb='git branch'
alias gba='git branch -a'
alias gdel='git branch -d'

# =============================================================================
#  Docker
# =============================================================================
alias dockerstop='docker stop $(docker ps -aq)'
alias dockerrm='docker rm -f $(docker ps -aq)'
alias dockerrmi='docker rmi -f $(docker images -q)'
