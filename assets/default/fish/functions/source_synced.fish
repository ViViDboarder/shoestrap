function source_synced
    # Sources a config file and corresponding local config file if it exists
    set -l shared_config "$fish_synced_dir/$argv[1].fish"
    set -l local_config "$fish_synced_dir/$argv[1].local.fish"
    if test -f "$shared_config"
        source "$shared_config"
    end
    if test -f "$local_config"
        source "$local_config"
    end
end
