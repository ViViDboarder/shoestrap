set -gx fish_function_path "$fish_synced_dir/functions" $fish_function_path
set -gx fish_complete_path "$fish_synced_dir/completions" $fish_complete_path

source_synced 'init/alias'
source_synced 'init/paths'
source_synced 'init/env'
