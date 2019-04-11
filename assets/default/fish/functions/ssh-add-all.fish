# Adds all private keys to ssh agent

# Adds a key to agent if it hasn't been added yet
function __maybe_ssh_add
    for key in $argv
        if grep -q 'PRIVATE KEY' $key
            ssh-add -l | grep -q "$key" ;or ssh-add $key
        end
    end
end

function ssh-add-all
    __maybe_ssh_add $HOME/.ssh/id_rsa_*
end
