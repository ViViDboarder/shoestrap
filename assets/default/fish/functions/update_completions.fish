function update_completions --description "Update completions for a command" --argument-names "target_command"
    # Usage: update_completions kubectl completion fish
    #
    # This generates new completions, sources them, and then saves it to your
    # user completions directory for future loading.

    if not set -q target_command ; or [ -z "$target_command" ]
        echo "Must pass some command to generate completions. eg: update_completions kubectl completion fish" 1>&2
        return 1
    end

    set --local completion_dir "$HOME/.config/fish/completions"
    if set -q XDG_CONFIG_HOME
        set --local completion_dir "$XDG_CONFIG_HOME"
    end

    if [ "$target_command" = "register-python-argcomplete" ]
        echo "Command was py $argv[-1]"
        set target_command $argv[-1]
    end

    set --local completion_path "$completion_dir/$target_command.fish"
    eval $argv[1..] | tee "$completion_path" | source
    echo "Completions for $target_command generated, sourced, and stored in $completion_path for future shells" 1>&2
end
