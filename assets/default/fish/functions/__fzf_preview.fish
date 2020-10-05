# A function that can be used as the preview function for FZF to make fancy previews with syntax highlighting
function __fzf_preview
    if file --mime "$argv" | grep -q binary
        echo "$argv is a binary file"
    else
        if command --quiet --search bat
            bat --color=always --line-range :500 "$argv"
        else if command --quiet --search chroma
            chroma "$argv" | head -250
        else if command --quiet --search coderay
            coderay "$argv" | head -250
        else
            head -250 "$argv"
        end
    end
end
