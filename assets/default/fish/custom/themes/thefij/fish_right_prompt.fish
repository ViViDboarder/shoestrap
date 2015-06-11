# TODO: [force_target] [virtualenv]
# TODO: Eventually... make pluggable so plugins can add to prompt

# function _atf_target
#   set -l org (atf-target 2> /dev/null) || return
#   echo " [$org]"
# end
#
set -xg VIRTUAL_ENV_DISABLE_PROMPT 1

function _force_target
  if [ (git config force.use) ]
    set -l org (force-target)
    echo " [$org]"
  end
end

function _virtual_env
  if [ $VIRTUAL_ENV ]
    set -l venv (basename "$VIRTUAL_ENV")
    echo " [$venv]"
  end
end

function fish_right_prompt -d 'Write out the right prompt of thefij theme'
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l normal (set_color normal)

  echo -n $green (_force_target) (_virtual_env)
  set_color normal
end
