function fish_theme --description "Sets fish theme"
    set -l theme_name $argv[1]
    for p in $fish_themes_path
        set -l theme_file "$p/$theme_name.fish"
        if test -f "$theme_file"
            source "$theme_file"
            return
        end
    end

    echo "Unknown theme $theme_name not in fish_themes_path"
    return 1
end

function __fish_theme_list --description "List all fish themes found in path"
    for p in $fish_themes_path
        for theme in $p/*.fish
            echo (basename "$theme" | string split -r -m1 .)[1]
        end
    end
end

# Add a completion for themes
complete --command fish_theme --arguments '(__fish_theme_list)' --no-files --description "Fish theme"
