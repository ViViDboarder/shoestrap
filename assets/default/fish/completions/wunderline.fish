# Completions for wunderline

function __fish_wunderline_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'wunderline' ]
    return 0
  end
  return 1
end

function __fish_wunderline_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

function __fish_wunderline_incomplete_tasks
  wunderline export 2> /dev/null | jq -r ".data.lists[].tasks[] | select(.completed == false) | .title"
end

function __fish_wunderline_lists
  wunderline export 2> /dev/null | jq -r ".data.lists[].title"
end

complete -c wl -w wunderline
complete -f -c wunderline -s h -l help -d 'Get help for this command'

complete -f -c wunderline -n '__fish_wunderline_needs_command' -a auth -d 'Authenticate Wunderline'

complete -f -c wunderline -n '__fish_wunderline_needs_command' -a add -d 'Add a task to your inbox'
complete -x -c wunderline -n '__fish_wunderline_using_command add' -s l -l list -a '(__fish_wunderline_lists)' -d 'Specify a list other than your inbox'
complete -f -c wunderline -n '__fish_wunderline_using_command add' -l starred -d 'Set the new task as starred'
complete -f -c wunderline -n '__fish_wunderline_using_command add' -l today -d 'Set the due date to today'
complete -f -c wunderline -n '__fish_wunderline_using_command add' -l tomorrow -d 'Set the due date to tomorrow'
complete -f -c wunderline -n '__fish_wunderline_using_command add' -l due -d 'Set a specified due date'
complete -f -c wunderline -n '__fish_wunderline_using_command add' -l note -d 'Attach a note to the new task'
complete -f -c wunderline -n '__fish_wunderline_using_command add' -l subtask -d 'Add a subtask to the new task'
complete -f -c wunderline -n '__fish_wunderline_using_command add' -s o -l open -d 'Open task in Wunderlist on completion'
complete -f -c wunderline -n '__fish_wunderline_using_command add' -s s -l stdin -d 'Create task from stdin'

complete -f -c wunderline -n '__fish_wunderline_needs_command' -a done -d 'Mark a task as done'
complete -f -c wunderline -n '__fish_wunderline_using_command done' -a '(__fish_wunderline_incomplete_tasks)'

complete -f -c wunderline -n '__fish_wunderline_needs_command' -a inbox -d 'View your inbox'
complete -f -c wunderline -n '__fish_wunderline_needs_command' -a starred -d 'View starred tasks'
complete -f -c wunderline -n '__fish_wunderline_needs_command' -a today -d 'View tasks due today'
complete -f -c wunderline -n '__fish_wunderline_needs_command' -a week -d 'View tasks due this week'
complete -f -c wunderline -n '__fish_wunderline_needs_command' -a all -d 'View all of your tasks'
complete -f -c wunderline -n '__fish_wunderline_needs_command' -a overdue -d 'View overdue tasks'

complete -x -c wunderline -n '__fish_wunderline_needs_command' -a search -d 'Search your tasks'
complete -x -c wunderline -n '__fish_wunderline_needs_command' -a list -d 'Search your lists'

complete -f -c wunderline -n '__fish_wunderline_needs_command' -a lists -d 'List your lists'

complete -f -c wunderline -n '__fish_wunderline_needs_command' -a open -d 'Open Wunderlist'
complete -f -c wunderline -n '__fish_wunderline_needs_command' -a export -d 'Export your data in JSON'
complete -f -c wunderline -n '__fish_wunderline_needs_command' -a whoami -d 'Display effective user'
complete -f -c wunderline -n '__fish_wunderline_needs_command' -a gc -d 'Delete completed tasks'
complete -f -c wunderline -n '__fish_wunderline_needs_command' -a set-platform -d 'Set your preferred application platform'
complete -f -c wunderline -n '__fish_wunderline_needs_command' -a flush -d 'Flush the application cache'
complete -x -c wunderline -n '__fish_wunderline_needs_command' -a help -d 'Display help for [cmd]'




