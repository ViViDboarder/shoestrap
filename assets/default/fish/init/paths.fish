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

    # Set go paths
    set goroot /opt/local/lib/go
    set gopath $HOME/workspace/go_path

    # set PATH $HOME/Library/Python/2.7/bin $PATH
    # Fix Python path on OSX to avoid considering System extras over newer versions
    set -gx PYTHONPATH /opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages /Library/Python/2.7/site-packages $PYTHONPATH
end

# Google GO
if [ -d "$goroot" ]
    set -gx GOROOT $goroot
    set -gx PATH $PATH $GOROOT/bin
end
if [ -d "$gopath" ]
    set -gx GOPATH $gopath
    set -gx PATH $PATH $GOPATH/bin
end

# Android paths
if [ -d "$android_sdk" ]
    set -gx ANDROID_HOME $android_sdk
    set -gx PATH $PATH $android_sdk/platform-tools $android_sdk/tools
end

# Home path
set -gx  PATH $HOME/bin $PATH

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Increase memory sizes for java using Ant
set -gx ANT_OPTS "-Xmx2048m -Xms512m"

# FZF
set -gx FZF_DEFAULT_COMMAND 'ag -g ""'
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND \$dir"
