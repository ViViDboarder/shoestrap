# name: ifij (forked from RobbyRussel)
# description: prompt containing minimal relevant information with host, path,
# and git status.

function _status_color
    # Returns a color for successful or failed previous command
    if test $__prompt_last_status -eq 0
        echo (set_color -o green)
    else
        echo (set_color -o red)
    end
end

function _hostname
    # Returns hostname if on remote host and not using tmux
    # Check if we're on a non-local host via ssh
    if set -q SSH_CLIENT; or set -q SSH_TTY
        # Check if we're using tmux, since tmux status line displays the host
        if not set -q TMUX
            echo (hostname -s)" "
        end
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
