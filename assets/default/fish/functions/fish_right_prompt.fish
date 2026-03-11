# This is exported because the venv is now included here
set -xg VIRTUAL_ENV_DISABLE_PROMPT 1

# Returns identifier for target from github.com/heroku/force
# requires teh following additional script
# https://github.com/ViViDboarder/shoestrap/blob/clean-shoes/assets/default/force-cli/force-target
function _force_target_name
    if [ (git config force.use) ]
        set -l org (force-target)
        echo "[$org]"
  end
end

function _virtual_env_name
    if [ $VIRTUAL_ENV ]
        set -l venv (basename "$VIRTUAL_ENV")
        echo "[$venv]"
  end
end

function _right_prompt_aux
    # To override use `funced _fish_right_prompt_user; and funcsave _fish_right_prompt_user`
    functions -q _fish_right_prompt_user; and _fish_right_prompt_user
end

function _ssh_agent_status
    if [ -n "$SSH_AGENT_PID" ]
        echo "[ssh-agent]"
    end
end

function fish_right_prompt
    # Set prompt showing temporary environment or subshell info
    echo -n (set_color green) (_force_target_name) (_virtual_env_name) (_ssh_agent_status) (_right_prompt_aux)
    set_color normal
end
