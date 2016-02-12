function __fish_force_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'force' ]
    return 0
  end
  return 1
end

function __fish_force_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

complete -f -c force -n '__fish_force_needs_command' -a login -d 'Log into an environment'
complete -f -c force -n '__fish_force_using_command login' -a '-i' -d 'Specify environment'

complete -f -c force -n '__fish_force_needs_command' -a push -d 'Push a change to Salesforce'
complete -f -c force -n '__fish_force_needs_command' -a test -d 'Run specified test name'
