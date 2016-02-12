# vim
alias nv='nvim'
alias tv='tmux-vim'
alias :q='exit'

# git
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log'
alias gr='git rebase'
alias gs='git status'
alias tiga='tig --all'

# cd
alias cd..='cd ..'

# vim
alias mviml='env VIM_COLOR=github mvim'

# terminal-notifier
alias notify-done='terminal-notifier -message "Done"'
alias notify-success='terminal-notifier -message "Success"'
alias notify-fail='terminal-notifier -message "Failure"'

function sh-notify
  [ $status = 0 ] ;and notify-success ;or notify-fail
end

# gopush
alias pb-done='pb "Done"'
alias pb-success='pb "Success"'
alias pb-failure='pb "Failure"'
function pb-notify
  [ $status = 0 ] ;and pb-success ;or pb-failure
end
