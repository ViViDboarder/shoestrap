# vim
abbr --global --add nv nvim
abbr --global --add tv tmux-vim
abbr --global --add :q exit

# git
abbr --global --add ga git add
abbr --global --add gc git commit
abbr --global --add gcm git commit -m
abbr --global --add gco git checkout
abbr --global --add gd git diff
abbr --global --add gl git log
abbr --global --add gr git rebase
abbr --global --add gs git status
abbr --global --add tiga tig --all

# cd
abbr --global --add cd.. cd ..

# vim
abbr --global --add mviml env VIM_COLOR=github mvim

# terminal-notifier
abbr --global --add notify-done terminal-notifier -message "Done"
abbr --global --add notify-success terminal-notifier -message "Success"
abbr --global --add notify-fail terminal-notifier -message "Failure"

function sh-notify
  [ $status = 0 ] ;and notify-success ;or notify-fail
end

# gopush
abbr --global --add pb-done pb "Done"
abbr --global --add pb-success pb "Success"
abbr --global --add pb-failure pb "Failure"
function pb-notify
  [ $status = 0 ] ;and pb-success ;or pb-failure
end

# notify-to-slack
abbr --global --add ns-done notify-to-slack Done
abbr --global --add ns-success notify-to-slack Success
abbr --global --add ns-failure notify-to-slack Failure
function ns-notify
  notify-to-slack --status $status "Done"
end

# kitty aliases
if [ "$TERM" = "xterm-kitty" ]; and type -q kitty
  alias ssh="kitty +kitten ssh"
  alias imgcat="kitty +kitten icat"
end

# Docker bake
abbr --global --add bake docker buildx bake
