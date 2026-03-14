# XDG Spec
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CACHE_HOME "$HOME/.cache"

# Increase memory sizes for java using Ant
set -gx ANT_OPTS "-Xmx2048m -Xms512m"

# Set default editor to vim or nvim
if type -q nvim
    set -gx EDITOR nvim
else
    set -gx EDITOR vim
end
set -gx VISUAL "$EDITOR"

# Interractive env variables
if status --is-interactive
    # FZF
    if type -q rg
        set -gx FZF_DEFAULT_COMMAND 'rg --files'
        # set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore-vcs --hidden'
    else if type -q ag
        set -gx FZF_DEFAULT_COMMAND 'ag -g ""'
    end
    if [ -n "$FZF_DEFAULT_COMMAND" ]
        set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND \$dir"
    end
    set -gx FZF_DEFAULT_OPTS "
    --preview-window=:hidden
    --preview='__fzf_preview {}'
    --bind '?:toggle-preview'
    "

    # Export colors
    eval ($HOME/bin/derive_colors.py --export --fish)

    # Check for nerd font
    if not set -q SSH_TTY ;and command -q fc-list ;and fc-list -q 'Symbols Nerd Font'
        # Doesn't guarantee the font is in use, but it's a good guess
        set -gx TERM_NERD_FONT 1
    end

    # Set fish theme based on newly exported colors
    if set -q FISH_THEME
        # Use builtin theme management if available
        if fish_config theme list | grep -q "$FISH_THEME"
            fish_config theme choose "$FISH_THEME"
        else
            # Otherwise set custom
            fish_theme "$FISH_THEME"
        end
    end
end
