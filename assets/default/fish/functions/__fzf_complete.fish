function __fzf_complete --description "Prints values passed as args or through stdin for completion through fzf, if available. This can be disabled by using ENABLE_FZF_COMPLETE"
    set -l cmd ""
    if count $argv > /dev/null
        set cmd "string split ' ' $argv"
    else
        set cmd "cat"
    end

    # Make fzf completion opt-in
    if type -q fzf ;and [ -n $ENABLE_FZF_COMPLETE ]
        set  -l last_arg (string trim (commandline -t))
        eval $cmd | fzf --query=$last_arg -d " " --exit-0 --select-1 --height 40% --min-height 10 --reverse
    else
        eval $cmd
    end
end
