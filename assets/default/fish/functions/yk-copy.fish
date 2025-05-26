function yk-copy --description "Select a credential using fzf and copy it to clipboard"
    set result (yk (yk list | fzf))

    if command -q pbcopy
        echo "$result" | pbcopy
    else if command -q xsel
        echo "$result" | xsel --clipboard
    else if command -q xclip
        echo "$result" | xclip
    else if command -q wl-copy
        echo "$result" | wl-copy
    else
        echo "No clipboard command found. Code is $result"
    end
end
