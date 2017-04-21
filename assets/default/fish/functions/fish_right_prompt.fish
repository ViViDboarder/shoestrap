# This is exported because the venv is now included here
set -xg VIRTUAL_ENV_DISABLE_PROMPT 1

# Returns identifier for target from github.com/heroku/force
# requires teh following additional script
# https://github.com/ViViDboarder/shoestrap/blob/clean-shoes/assets/default/force-cli/force-target
function _force_target
  if [ (git config force.use) ]
    set -l org (force-target)
    echo "[$org]"
  end
end

function _virtual_env
  if [ $VIRTUAL_ENV ]
    set -l venv (basename "$VIRTUAL_ENV")
    echo "[$venv]"
  end
end

function _right_prompt_aux
    # To override use `funced _fish_right_prompt_user; and funcsave _fish_right_prompt_user`
    functions -q _fish_right_prompt_user; and _fish_right_prompt_user
end

function fish_right_prompt
  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l green (set_color -o green)
  set -l normal (set_color normal)

  echo -n $green (_force_target) (_virtual_env) (_right_prompt_aux)
  set_color normal
end
