# completions for mage build system for golang

function __mage_list_targets --description 'list all mage targets'
    mage -l | awk '/^  / { gsub(/\*/, "", $1); print $1; }'
end

complete --command mage --old-option h --no-files --description 'show help'
complete --command mage --old-option clean --no-files --description 'clean out generated binaries'
complete --command mage --old-option init --no-files --description 'create a starting template if no magefile exists'
complete --command mage --old-option l --no-files --description 'list mage targets'
complete --command mage --old-option version --no-files --description 'show version'
complete --command mage --old-option d --description 'dir to read magefiles from'
complete --command mage --old-option f --no-files --description 'force recreation of compiled magefile'
complete --command mage --old-option goarch --no-files --description 'set GOARCH for binary created by -compile'
complete --command mage --old-option gocmd --no-files --description 'use given go binary for compilation'
complete --command mage --old-option goos --no-files --description 'set GOOS for binary created by -compile'
complete --command mage --old-option keep --no-files --description 'keep intermediate magefiles after running'
complete --command mage --old-option t --no-files --description 'timeout duration'
complete --command mage --old-option v --no-files --description 'verbose logging'
complete --command mage --old-option w --description 'working dir'
complete --command mage --old-option compile --description 'compile binary to path'
complete --command mage --no-files -a '(__mage_list_targets)' --description 'Target'
