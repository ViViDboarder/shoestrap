# name: ifij (forked from RobbyRussel)

function _status_color
  # Returns a color for successful or failed previous command
  if test $__prompt_last_status -eq 0
      echo (set_color -o green)
  else
      echo (set_color -o red)
  end
end

function _hostname
  # Returns the hostname if not using tmux since tmux will display
  if [ -z $TMUX ]
    echo (hostname -s)" "
  end
end

function _prompt_char
  # Gives a colored prompt char for user or root
  echo -n (_status_color)
  if [ (whoami) = 'root' ]
    echo -n '#'
  else
    echo -n '$'
  end
  echo -n (set_color normal)
end

function fish_prompt
  # Build full left side prompt

  # Collect last status for coloring prompt
  set -g __prompt_last_status $status

  # Configure git prompt
  set -g __fish_git_prompt_showcolorhints 1
  set -g __fish_git_prompt_showdirtystate 1
  set -g __fish_git_prompt_showstashstate 1
  set -g __fish_git_prompt_showuntrackedfiles 1
  echo -n -s $arrow (_hostname) (prompt_pwd) (__fish_git_prompt) (_prompt_char) ' '
end
