if not contains -- "$fish_synced_dir/functions" $fish_function_path
    set --prepend fish_function_path "$fish_synced_dir/functions"
end
if not contains -- "$fish_synced_dir/completions" $fish_complete_path
    set --prepend fish_complete_path "$fish_synced_dir/completions"
end
if not contains -- "$fish_synced_dir/themes" $fish_themes_path
    set --path --prepend fish_themes_path "$fish_synced_dir/themes"
end

function _source_synced --description "Sources file from synced dir as well as optional local file"
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
    _source_synced 'init/alias'
end
_source_synced 'init/paths'
_source_synced 'init/env'
