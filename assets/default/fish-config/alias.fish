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

# function sh-notify
#   ($argv) ;and notify-success ;or notify-fail
# end

# gl-notifire
alias gl-notify-done='gl-notifier "Done"'
alias gl-notify-success='gl-notifier "Success"'
alias gl-notify-fail='gl-notifier "Failure"'

# function gl-notify
#   ($argv) ;and gl-notify-success ;or gl-notify-fail
# end

# gopush
alias pb-done='pb "Done"'
alias pb-success='pb "Success"'
alias pb-failure='pb "Failure"'
# function pb-notify
#   ($argv) ;and pb-success ;or pb-failure
# end
