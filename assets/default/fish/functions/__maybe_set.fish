function __maybe_set --description "Either appends or prepends to a variable if the file or directory exists and isn't already present"
    # Replicate some of the `set` args
    argparse 'a/append' 'p/prepend' 'x/export' 'g/global' -- $argv
    if [ (count $argv) -ne 2 ]
        echo "_maybe_set Requires exactly two arguments"
        return 1
    end
    set -l var_name "$argv[1]"
    set -l existing_val (eval 'echo $'(echo $var_name))
    set -l new_value "$argv[2]"
    if not contains -- "$new_value" "$existing_val" ;and test -e "$new_value"
        set $_flag_append $_flag_prepend $_flag_export $_flag_global $var_name $new_value
    end
end
