# Extends fzf-file-widget by changing the FZF_CTRL_T_COMMAND based on context
# Should be added to fish_user_keybindings after fzf_key_bindings
# Author: ViViDboarder
function fzf_key_bindings_enhanced
  function fzf-enhanced-widget -d "FZF widget that takes command and args via args"
    set -lx FZF_CTRL_T_COMMAND $argv[1]
    set -lx FZF_CTRL_T_OPTS $FZF_CTRL_T_OPTS
    if [ (count $argv) -gt 1 ]
      set FZF_CTRL_T_OPTS $argv[2]
    end
    set -l commandline (__fzf_parse_commandline)
    set -l fzf_query $commandline[2]

    set -q FZF_TMUX_HEIGHT; or set FZF_TMUX_HEIGHT 40%
    begin
      set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS"
      eval "$FZF_CTRL_T_COMMAND | "(__fzfcmd)' -m --query "'$fzf_query'"' | while read -l r; set result $result $r; end
    end
    if [ -z "$result" ]
      commandline -f repaint
      return
    else
      # Remove last token from commandline.
      commandline -t ""
    end
    for i in $result
      commandline -it -- (string escape $i)
      commandline -it -- ' '
    end
    commandline -f repaint
  end

  function fzf-enhanced-binding -d 'List files or other completions based on context'
    set -l cmd (commandline -opc)
    if [ (count $cmd) -gt 1 -a "$cmd[1]" = "python" -a "$cmd[-1]" = "-m" ]
      # List python modules
      set -l FZF_CTRL_T_COMMAND "ag --py -g '' | sed -e 's/\//./g' -e 's/\(.__init__\)*.py\$//'"
      fzf-enhanced-widget "$FZF_CTRL_T_COMMAND"
    end
    fzf-file-widget
  end

  bind \ct fzf-enhanced-binding
  if bind -M insert >> /dev/null 2>&1
    bind -M insert \ct fzf-enhanced-binding
  end
end
