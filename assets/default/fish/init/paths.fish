function _maybe_set --description "Either appends or prepends to a variable if the file or directory exists and isn't already present"
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

set det_os "unknown"
switch (uname)
    case "Darwin"
        set det_os "mac"
    case "Linux"
        set det_os "linux"
    case '*'
        set det_os "unknown"
end

# opt directory
_maybe_set -p PATH /opt/local/sbin
_maybe_set -p PATH /opt/local/bin
if test -e "/opt/local/lib"
    set -gx --append LDFLAGS "-L/opt/local/lib"
end
if test -e "/opt/local/include"
    set -gx --append CFLAGS "-I/opt/local/include"
end

# Set python paths
if [ $det_os = "mac" ]
    # Fix Python path on OSX to avoid considering System extras over newer versions
    # Local
    _maybe_set -p PATH "$HOME/Library/Python/2.7/bin"
    _maybe_set -p PATH "$HOME/Library/Python/3.9/bin"
    # set -gx PYTHONPATH $HOME/Library/Python/2.7/lib/python/site-packages:$PYTHONPATH
    # Macports
    _maybe_set -a PATH /opt/local/Library/Frameworks/Python.framework/Versions/Current/bin
    # set -gx PYTHONPATH /opt/local/Library/Frameworks/Python.framework/Versions/Current/lib $PYTHONPATH
    # set -gx PYTHONPATH /opt/local/Library/Frameworks/Python.framework/Versions/Current/lib/python2.7/site-packages /Library/Python/2.7/site-packages $PYTHONPATH
end

# NPM paths
if command -q npm
    set npm_path "$HOME/.npm/bin"
    if [ ! -d "$npm_path" ]
        # It's more robust to use the subshell, but far slower
        set npm_path (npm bin -g 2> /dev/null)
    end
    _maybe_set -a PATH "$npm_path"
end

# Add rust cargo path
_maybe_set -p PATH "$HOME/.cargo/bin"

# Golang paths
set -gx GOPATH $HOME/workspace/go_path
_maybe_set -p PATH "$GOPATH/bin"
_maybe_set -p PATH "/usr/local/go/bin"

# Android paths
if [ $det_os = "linux" ]
    set -gx ANDROID_HOME "$HOME/workspace/adt-bundle-linux/sdk"
else if [ $det_os = "mac" ]
    set -gx ANDROID_HOME "$HOME/workspace/android-sdk-macosx"
end
_maybe_set -a PATH "$ANDROID_PATH/platform-tools"
_maybe_set -a PATH "$ANDROID_PATH/tools"

# Ruby paths
if type -q rbenv ; and status --is-interactive
    _maybe_set -a PATH "$HOME/.rbenv/shims"
else if [ -d "$HOME/.rvm" ]
    _maybe_set -a PATH "$HOME/.rvm/bin"
    source "$HOME/.rvm/scripts/extras/rvm.fish"
end

# Home paths to take final precedent
_maybe_set -p PATH "$HOME/.local/bin"
_maybe_set -p PATH "$HOME/bin"
