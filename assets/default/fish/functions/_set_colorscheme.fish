function _set_colorscheme --description "Sets the fish colorscheme"
  set -l theme "$argv[1]"
  switch "$theme"
    case "solarized light"
      set -g fish_color_autosuggestion 93a1a1
      set -g fish_color_cancel -r
      set -g fish_color_command 586e75
      set -g fish_color_comment 93a1a1
      set -g fish_color_cwd green
      set -g fish_color_cwd_root red
      set -g fish_color_end 268bd2
      set -g fish_color_error dc322f
      set -g fish_color_escape 00a6b2
      set -g fish_color_history_current --bold
      set -g fish_color_host normal
      set -g fish_color_match --background=brblue
      set -g fish_color_normal normal
      set -g fish_color_operator 00a6b2
      set -g fish_color_param 657b83
      set -g fish_color_quote 839496
      set -g fish_color_redirection 6c71c4
      set -g fish_color_search_match bryellow --background=white
      set -g fish_color_selection white --bold --background=brblack
      set -g fish_color_user brgreen
      set -g fish_color_valid_path --underline
      set -g fish_pager_color_completion green
      set -g fish_pager_color_description B3A06D
      set -g fish_pager_color_prefix cyan --underline
      set -g fish_pager_color_progress brwhite --background=cyan
    case "solarized dark"
      set -g fish_color_autosuggestion 586e75
      set -g fish_color_cancel -r
      set -g fish_color_command 93a1a1
      set -g fish_color_comment 586e75
      set -g fish_color_cwd green
      set -g fish_color_cwd_root red
      set -g fish_color_end 268bd2
      set -g fish_color_error dc322f
      set -g fish_color_escape 00a6b2
      set -g fish_color_history_current --bold
      set -g fish_color_host normal
      set -g fish_color_match --background=brblue
      set -g fish_color_normal normal
      set -g fish_color_operator 00a6b2
      set -g fish_color_param 839496
      set -g fish_color_quote 657b83
      set -g fish_color_redirection 6c71c4
      set -g fish_color_search_match bryellow --background=black
      set -g fish_color_selection white --bold --background=brblack
      set -g fish_color_user brgreen
      set -g fish_color_valid_path --underline
      set -g fish_pager_color_completion B3A06D
      set -g fish_pager_color_description B3A06D
      set -g fish_pager_color_prefix cyan --underline
      set -g fish_pager_color_progress brwhite --background=cyan
  end
end
