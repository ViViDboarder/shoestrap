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

# Google GO
set -gx GOROOT /usr/local/go
if [ -d "$GOROOT" ]
    set -gx PATH $PATH $GOROOT/bin
end

if [ $det_os = "linux" ]
    set android_sdk $HOME/workspace/adt-bundle-linux/sdk
else if [ $det_os = "mac" ]
    set android_sdk $HOME/workspace/android-sdk-macosx

    set go_workspace $HOME/workspace/go_workspace
    if [ -d "$go_workspace" ]
        set -gx GOPATH $go_workspace
        set -gx PATH $PATH $GOPATH/bin
    end

    # set PATH $HOME/Library/Python/2.7/bin $PATH
    # Fix Python path on OSX to avoid considering System extras over newer versions
    set -gx PYTHONPATH /opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages /Library/Python/2.7/site-packages $PYTHONPATH
end

# Google cloud sdk
# set sdk_dir "$HOME/workspace/google-cloud-sdk"
# set bin_path "$sdk_dir/bin"
# set -gx PATH $bin_path $PATH
# set -gx PYTHONPATH "$sdk_dir/platform/google_appengine" $PYTHONPATH

# Android paths
set -gx ANDROID_HOME $android_sdk
set -gx PATH $PATH $android_sdk/platform-tools $android_sdk/tools

# Home path
set -gx  PATH $HOME/bin $PATH

#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Increase memory sizes for java using Ant
set -gx ANT_OPTS "-Xmx2048m -Xms512m"
