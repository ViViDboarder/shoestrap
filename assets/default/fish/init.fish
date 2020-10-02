set -gx fish_function_path "$fish_synced_dir/functions" $fish_function_path
set -gx fish_complete_path "$fish_synced_dir/completions" $fish_complete_path

function source_synced --description "Sources file from synced dir as well as optional local file"
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

if status --is-interactive
    source_synced 'init/alias'
end
source_synced 'init/paths'
source_synced 'init/env'
