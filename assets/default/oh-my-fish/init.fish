function source_config
    # Sources a config file and corresponding local config file if it exists
    set shared_config "$OMF_CONFIG/$argv[1].fish"
    set local_config "$OMF_CONFIG/$argv[1].local.fish"
    if test -f "$shared_config"
        source "$shared_config"
    end
    if test -f "$local_config"
        source "$local_config"
    end
end

source_config paths
source_config alias
