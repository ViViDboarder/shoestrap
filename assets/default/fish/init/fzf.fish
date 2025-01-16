if fzf --fish 2&> /dev/null
    fzf --fish | source
else
    # If we can't get completions from fzf, we can get the last built
    # completions and functions here
    source $fish_synced_dir/init/fzf_integration.fish
end
