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
if [ -d /opt/local ]
    set -gx PATH /opt/local/bin /opt/local/sbin $PATH
end

if [ $det_os = "linux" ]
    set android_sdk $HOME/workspace/adt-bundle-linux/sdk
else if [ $det_os = "mac" ]
    set android_sdk $HOME/workspace/android-sdk-macosx

    # Fix Python path on OSX to avoid considering System extras over newer versions
    # Local
    set -gx PATH $HOME/Library/Python/3.7/bin $HOME/Library/Python/2.7/bin $PATH
    set -gx PYTHONPATH $HOME/Library/Python/2.7/lib/python/site-packages:$PYTHONPATH
    # Macports
    set -gx PATH $PATH /opt/local/Library/Frameworks/Python.framework/Versions/Current/bin
    # set -gx PYTHONPATH /opt/local/Library/Frameworks/Python.framework/Versions/Current/lib $PYTHONPATH
    # set -gx PYTHONPATH /opt/local/Library/Frameworks/Python.framework/Versions/Current/lib/python2.7/site-packages /Library/Python/2.7/site-packages $PYTHONPATH
end

# NPM paths
if type -q npm
    set npm_path (npm bin -g 2> /dev/null)
    if [ -d "$npm_path" ]
        set -gx PATH $npm_path $PATH
    end
end

# Add rust path
if [ -d "$HOME/.cargo/bin" ]
    set -gx PATH $HOME/.cargo/bin $PATH
end

# Golang paths
set -gx GOPATH $HOME/workspace/go_path
if [ -d "$GOPATH" ]
    set -gx PATH $GOPATH/bin $PATH
end

# Android paths
if [ -d "$android_sdk" ]
    set -gx ANDROID_HOME $android_sdk
    set -gx PATH $PATH $android_sdk/platform-tools $android_sdk/tools
end

# Ruby paths
if type -q rbenv ; and status --is-interactive
    source (rbenv init -|psub)
else if [ -d "$HOME/.rvm" ]
    set -gx PATH $PATH $HOME/.rvm/bin
    source "$HOME/.rvm/scripts/extras/rvm.fish"
end

# Home paths
if [ -d "$HOME/.local/bin" ]
    set -gx PATH $HOME/.local/bin $PATH
end
if [ -d "$HOME/bin" ]
    set -gx PATH $HOME/bin $PATH
end
