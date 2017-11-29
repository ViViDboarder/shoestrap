# Use FZF to complete python modules rather than standard file completion
complete -c python -s m -a "(ag --py -g '' | sed -e 's/\//./g' -e 's/\(.__init__\)*.py\$//' | fzf --reverse --height 40%)"
