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
    set -gx GOPATH $HOME/workspace/go_path

    # set PATH $HOME/Library/Python/2.7/bin $PATH
    # Fix Python path on OSX to avoid considering System extras over newer versions
    set -gx PYTHONPATH /opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages:$PYTHONPATH
    set -gx PATH $PATH /opt/local/Library/Frameworks/Python.framework/Versions/Current/bin
end

# Google GO
if [ -d "$GOPATH" ]
    set -gx PATH $PATH $GOPATH/bin
end

# Android paths
if [ -d "$android_sdk" ]
    set -gx ANDROID_HOME $android_sdk
    set -gx PATH $PATH $android_sdk/platform-tools $android_sdk/tools
end

# Ruby paths
# Add RVM to PATH for scripting
if [ -d "$HOME/.rvm" ]
    set -gx PATH $PATH $HOME/.rvm/bin
end

# Home path
set -gx  PATH $HOME/bin $HOME/.local/bin  $PATH
