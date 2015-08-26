# name: ifij (forked from RobbyRussel)
#
# You can override some default options in your config.fish:
#   set -g theme_display_git_untracked no

function _status_color
  # Returns a color for successful or failed previous command
  if test $last_status -eq 0
      echo (set_color -o green)
  else
      echo (set_color -o red)
  end
end

function _git_branch_name
  # Returns the name of the current git branch
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  # Returns whether or not there is anything uncommitted
  set -l show_untracked (git config --bool bash.showUntrackedFiles)
  set untracked ''
  if [ "$theme_display_git_untracked" = 'no' -o "$show_untracked" = 'false' ]
    set untracked '--untracked-files=no'
  end
  echo (command git status -s --ignore-submodules=dirty $untracked ^/dev/null)
end

function _git_info
  # Returns what is to be displayed for the git info
  if [ (_git_branch_name) ]
    if [ (_is_git_dirty) ]
        set branch_color (set_color -o red)
    else
        set branch_color (set_color -o yellow)
    end
    set -l git_branch (_git_branch_name)
    echo " $branch_color($git_branch)"(set_color normal)
  end
end

function _hostname
  # Returns the hostname if not using tmux since tmux will display
  if [ -z $TMUX ]
    echo (hostname)" "
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

  # NOTE: this becomes a global variable
  set -g last_status $status

  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l normal (set_color normal)

  set -l arrow (_status_color) "➜ $normal"
  set -l cwd (basename (prompt_pwd))

  echo -n -s $arrow (_hostname) $cwd (_git_info) (_prompt_char) ' '
end

