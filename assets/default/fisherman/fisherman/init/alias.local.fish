# yelp
alias moshdev='mosh dev7-devc fish'
alias sshadev='ssh -t -A dev7-devc fish'
# Copy remote tmux clipboard
alias rpbcopy='ssh dev7-devc "TMPDIR=/nail/tmp tmux show-buffer" | pbcopy'
alias rmpbcopy='mosh dev7-devc "TMPDIR=/nail/tmp tmux show-buffer" | pbcopy'

alias force-login-dev='force login ;and rsync -av /Users/ifij/.force/accounts/ dev7-devc:~/.force/accounts'

# projects
alias cd-sf='cd ~/workspace/salesforce-apex'

# vagrant
alias vssh='vagrant ssh'
alias vmosh='mosh vagrant@localhost -p 2222'
alias vrl='vagrant reload'
alias vbm='mosh -p 3122 --ssh="ssh -p 3022" ifij@localhost'
