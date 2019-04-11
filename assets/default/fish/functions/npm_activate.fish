function npm_activate
    set -gx OLD_PATH $PATH
    set -gx PATH (npm bin) $PATH
end

function npm_deactivate
    if [ "$OLD_PATH" != "" ]
        set -gx PATH $OLD_PATH
        set -e OLD_PATH
    end
end
