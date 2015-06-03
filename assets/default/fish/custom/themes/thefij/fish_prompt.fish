# name: RobbyRussel
#
# You can override some default options in your config.fish:
#   set -g theme_display_git_untracked no

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
  set -l show_untracked (git config --bool bash.showUntrackedFiles)
  set untracked ''
  if [ "$theme_display_git_untracked" = 'no' -o "$show_untracked" = 'false' ]
    set untracked '--untracked-files=no'
  end
  echo (command git status -s --ignore-submodules=dirty $untracked ^/dev/null)
end

function _prompt_char
  if [ (whoami) = 'root' ]
    echo '#'
  else
    echo '$'
  end
end

function fish_prompt
  set -l last_status $status
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l normal (set_color normal)

  if test $last_status = 0
      set arrow "$green➜ "
  else
      set arrow "$red➜ "
  end
  set -l cwd $normal(basename (prompt_pwd))

  if [ (_git_branch_name) ]
    if [ (_is_git_dirty) ]
        set branch_color "$red"
    else
        set branch_color "$yellow"
    end
    set -l git_branch (_git_branch_name)
    set git_info " $branch_color($git_branch)"
  end

  echo -n -s $arrow $cwd $git_info $normal (_prompt_char) ' '
end

