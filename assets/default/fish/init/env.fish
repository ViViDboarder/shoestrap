# XDG Spec
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CACHE_HOME "$HOME/.cache"

# Increase memory sizes for java using Ant
set -gx ANT_OPTS "-Xmx2048m -Xms512m"

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

# Vim Colors so that they can be set by env
set -q VIM_COLOR; set -gx VIM_COLOR (eval $HOME/bin/get_vim_colorscheme.sh); or set -gx VIM_COLOR wombat256mod
