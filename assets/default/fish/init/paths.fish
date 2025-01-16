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
__maybe_set -p PATH /opt/local/sbin
__maybe_set -p PATH /opt/local/bin
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
    __maybe_set -p PATH "$HOME/Library/Python/2.7/bin"
    __maybe_set -p PATH "$HOME/Library/Python/3.8/bin"
    __maybe_set -p PATH "$HOME/Library/Python/3.9/bin"
    __maybe_set -p PATH "$HOME/Library/Python/3.10/bin"
    __maybe_set -p PATH "$HOME/Library/Python/3.11/bin"
    # set -gx PYTHONPATH $HOME/Library/Python/2.7/lib/python/site-packages:$PYTHONPATH
    # Macports
    __maybe_set -a PATH /opt/local/Library/Frameworks/Python.framework/Versions/Current/bin
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
    __maybe_set -a PATH "$npm_path"
end

# Add luarocks paths
if command -q luarocks
    eval (luarocks path | sed "s/export/set -gx/;s/=/ /")
    __maybe_set -a PATH "$HOME/.luarocks/bin"
end

# Add rust cargo path
__maybe_set -p PATH "$HOME/.cargo/bin"

# Golang paths
set -gx GOPATH $HOME/workspace/go_path
__maybe_set -p PATH "$GOPATH/bin"
__maybe_set -p PATH "/usr/local/go/bin"

# Android paths
if [ $det_os = "linux" ]
    set -gx ANDROID_HOME "$HOME/workspace/adt-bundle-linux/sdk"
else if [ $det_os = "mac" ]
    set -gx ANDROID_HOME "$HOME/Library/Android/sdk"
end
__maybe_set -a PATH "$ANDROID_HOME/tools"
__maybe_set -a PATH "$ANDROID_HOME/tools/bin"
__maybe_set -a PATH "$ANDROID_HOME/platform-tools"

# Java paths
if type -q /usr/libexec/java_home && /usr/libexec/java_home &> /dev/null
    set -gx JAVA_HOME (/usr/libexec/java_home)
end

# Ruby paths
if type -q rbenv ; and status --is-interactive
    __maybe_set -a PATH "$HOME/.rbenv/shims"
else if [ -d "$HOME/.rvm" ]
    __maybe_set -a PATH "$HOME/.rvm/bin"
    source "$HOME/.rvm/scripts/extras/rvm.fish"
end

# Home paths to take final precedent
__maybe_set -p PATH "$HOME/.local/bin"
__maybe_set -p PATH "$HOME/bin"
