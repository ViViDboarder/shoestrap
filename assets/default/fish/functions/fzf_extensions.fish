# A function that can be used as the preview function for FZF to make fancy previews with syntax highlighting
function __fzf_preview
    if file --mime "$argv" | grep -q binary
        echo "$argv is a binary file"
    else
        coderay "$argv" ;or cat "$argv" 2> /dev/null | head -250
    end
end
