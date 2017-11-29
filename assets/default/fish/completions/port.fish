function __fish_port_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'port' ]
    return 0
  end
  return 1
end

function __fish_port_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

function __fish_port_list
    port list | cut -d' ' -f1
end

function __fish_port_inactive
    port echo inactive | sed 's/ \{1,\}/ /g'
end

function __fish_port_active
    port echo active | sed 's/ \{1,\}/ /g'
end

function __fish_port_installed
    port echo installed | sed 's/ \{1,\}/ /g'
end

function __fish_port_outdated_formulas
    port echo outdated | cut -d' ' -f1
end

set -l pseudo_portnames = 'all current active inactive actintact installed uninstalled outdated obsolete requested unrequested leaves'

############
# commands #
############

complete -f -c port -n '__fish_port_needs_command' -s v -d 'Verbose mode'
complete -f -c port -n '__fish_port_needs_command' -s d -d 'Debug mode'
complete -f -c port -n '__fish_port_needs_command' -s q -d 'Quiet mode, implies -N'
complete -f -c port -n '__fish_port_needs_command' -s N -d 'Non-interactive mode'
complete -f -c port -n '__fish_port_needs_command' -s n -d 'Do not follow dependencies for upgrade/install'
complete -f -c port -n '__fish_port_needs_command' -s R -d 'Also upgrade dependents'
complete -f -c port -n '__fish_port_needs_command' -s u -d 'Uninstall inactive ports when upgrading and uninstalling'
complete -f -c port -n '__fish_port_needs_command' -s y -d 'Performa  dry run'
complete -f -c port -n '__fish_port_needs_command' -s s -d 'Source-only mode'
complete -f -c port -n '__fish_port_needs_command' -s b -d 'Binary-only mode'
complete -f -c port -n '__fish_port_needs_command' -s c -d 'Autoclean mode'
complete -f -c port -n '__fish_port_needs_command' -s k -d 'Keep mode, do not autoclean after install'
complete -f -c port -n '__fish_port_needs_command' -s p -d 'Proceed after errors'
complete -f -c port -n '__fish_port_needs_command' -s o -d 'Honort state files if Portfile was modified'
complete -f -c port -n '__fish_port_needs_command' -s t -d 'Enable trace mode for debugging'
complete -f -c port -n '__fish_port_needs_command' -s f -d 'Force mode, ignore state file'
complete -r -c port -n '__fish_port_needs_command' -s D -d 'Specify portdir'
complete -r -c port -n '__fish_port_needs_command' -s F -d 'Read and proccess the file of commands'


# activate
complete -f -c port -n '__fish_port_needs_command' -a activate -d 'Activates installed portname'
complete -f -c port -n '__fish_port_using_command activate' -l no-exec -d 'Do not execute any stored pre- or post-uninstall procedures'
complete -x -c port -n '__fish_port_using_command activate' -a '(__fish_port_inactive)'

# # cat
# complete -f -c port -n '__fish_port_needs_command' -a cat -d 'Display formula'
# complete -f -c port -n '__fish_port_using_command cat' -a '(__fish_port_list)'
#
# # create
# complete -f -c port -n '__fish_port_needs_command' -a create -d 'Create new formula from URL'
# complete -f -c port -n '__fish_port_using_command create' -l cmake -d 'Use template for CMake-style build'
# complete -f -c port -n '__fish_port_using_command create' -l autotools -d 'Use template for Autotools-style build'
# complete -f -c port -n '__fish_port_using_command create' -l no-fetch -d 'Don\'t download URL'
#
# # deps
# complete -f -c port -n '__fish_port_needs_command' -a deps -d 'Show a formula\'s dependencies'
# complete -f -c port -n '__fish_port_using_command deps' -l 1 -d 'Show only 1 level down'
# complete -f -c port -n '__fish_port_using_command deps' -s n -d 'Show in topological order'
# complete -f -c port -n '__fish_port_using_command deps' -l tree -d 'Show dependencies as tree'
# complete -f -c port -n '__fish_port_using_command deps' -l all -d 'Show dependencies for all formulae'
# complete -f -c port -n '__fish_port_using_command deps' -a '(__fish_port_list)'
#
# # diy
# complete -f -c port -n '__fish_port_needs_command' -a 'diy configure' -d 'Determine installation prefix for non-port software'
# complete -f -c port -n '__fish_port_using_command diy' -l set-name -d 'Set name of package'
# complete -f -c port -n '__fish_port_using_command diy' -l set-version -d 'Set version of package'
#
# complete -f -c port -n '__fish_port_needs_command' -a 'doctor' -d 'Check your system for problems'
# complete -f -c port -n '__fish_port_needs_command' -a 'edit' -d 'Open port/formula for editing'
#
# # fetch
# complete -f -c port -n '__fish_port_needs_command' -a fetch -d 'Download source for formula'
# complete -f -c port -n '__fish_port_using_command fetch' -l force -d 'Remove a previously cached version and re-fetch'
# complete -f -c port -n '__fish_port_using_command fetch' -l HEAD -d 'Download the HEAD version from a VCS'
# complete -f -c port -n '__fish_port_using_command fetch' -l deps -d 'Also download dependencies'
# complete -f -c port -n '__fish_port_using_command fetch' -s v -d 'Make HEAD checkout verbose'
# complete -f -c port -n '__fish_port_using_command fetch' -a '(__fish_port_list)'
#
# complete -f -c port -n '__fish_port_needs_command' -a 'help' -d 'Display help'
#
# # home
# complete -f -c port -n '__fish_port_needs_command' -a home -d 'Open port/formula\'s homepage'
# complete -c port -n '__fish_port_using_command home' -a '(__fish_port_list)'
#
# # info
# complete -f -c port -n '__fish_port_needs_command' -a 'info abv' -d 'Display information about formula'
# complete -f -c port -n '__fish_port_using_command info' -l all -d 'Display info for all formulae'
# complete -f -c port -n '__fish_port_using_command info' -l github -d 'Open the GitHub History page for formula'
# complete -c port -n '__fish_port_using_command info' -a '(__fish_port_list)'

# install
complete -f -c port -n '__fish_port_needs_command' -a 'install' -d 'Install and activate portname'
complete -f -c port -n '__fish_port_using_command install' -l no-rev-upgrade -d 'Do not run rev-upgrade after installation'
complete -f -c port -n '__fish_port_using_command install' -l unrequested -d 'Do not mark the installed ports as requested'
complete -x -c port -n '__fish_port_using_command install' -a '(__fish_port_list)' -d 'portname'

# # link
# complete -f -c port -n '__fish_port_needs_command' -a 'link ln' -d 'Symlink installed formula'
# complete -f -c port -n '__fish_port_using_command link' -a '(__fish_port_installed)'
# complete -f -c port -n '__fish_port_using_command ln' -a '(__fish_port_installed)'

# list
complete -f -c port -n '__fish_port_needs_command' -a 'list ls' -d 'List all installed formula'
complete -f -c port -n '__fish_port_using_command list' -l unported -d 'List all files in the Homeport prefix not installed by port'
complete -f -c port -n '__fish_port_using_command list' -l versions -d 'Show the version number'
complete -x -c port -n '__fish_port_using_command list' -a "$pseudo_portnames" -d 'pseudo portname'
complete -x -c port -n '__fish_port_using_command list' -a '(__fish_port_list)' -d 'portname'

# #ls
# complete -f -c port -n '__fish_port_using_command ls' -l unported -d 'List all files in the Homeport prefix not installed by port'
# complete -f -c port -n '__fish_port_using_command ls' -l versions -d 'Show the version number'
# complete -c port -n '__fish_port_using_command ls' -a '(__fish_port_list)'
#
# # log
# complete -f -c port -n '__fish_port_needs_command' -a log -d 'Show log for formula'
# complete -c port -n '__fish_port_using_command log' -a '(__fish_port_list)' -d 'formula'
#
# # missing
# complete -f -c port -n '__fish_port_needs_command' -a missing -d 'Check formula for missing dependencies'
# complete -c port -n '__fish_port_using_command missing' -a '(__fish_port_list)' -d 'formula'
#
# # options
# complete -f -c port -n '__fish_port_needs_command' -a options -d 'Display install options for formula'
# complete -c port -n '__fish_port_using_command options' -a '(__fish_port_list)' -d 'formula'
#
# # outdated
# complete -f -c port -n '__fish_port_needs_command' -a outdated -d 'Show formula that have updated versions'
# complete -f -c port -n '__fish_port_using_command outdated' -l quiet -d 'Display only names'
#
# # prune
# complete -f -c port -n '__fish_port_needs_command' -a prune -d 'Remove dead symlinks'
#
# # search
# complete -f -c port -n '__fish_port_needs_command' -a 'search -S' -d 'Search for formula by name'
# complete -f -c port -n '__fish_port_using_command search' -l macports -d 'Search on MacPorts'
# complete -f -c port -n '__fish_port_using_command search' -l fink -d 'Search on Fink'
# complete -f -c port -n '__fish_port_using_command -S' -l macports -d 'Search on MacPorts'
# complete -f -c port -n '__fish_port_using_command -S' -l fink -d 'Search on Fink'
#
# # tap
# complete -f -c port -n '__fish_port_needs_command' -a tap -d 'Tap a new formula repository on GitHub'
#
# # test
# complete -f -c port -n '__fish_port_needs_command' -a test -d 'Run tests for formula'
# complete -c port -n '__fish_port_using_command test' -a '(__fish_port_list)' -d 'formula'
#
# # uninstall
complete -f -c port -n '__fish_port_needs_command' -a 'uninstall' -d 'Uninstall port'
complete -x -c port -n '__fish_port_using_command uninstall' -a '(__fish_port_installed)'
complete -f -c port -n '__fish_port_using_command uninstall' -l follow-dependents -d 'Also uninstall all ports recurively depending on this'
complete -f -c port -n '__fish_port_using_command uninstall' -l follow-dependencies -d 'Also recursively uninstall all ports that this depends on'
complete -f -c port -n '__fish_port_using_command uninstall' -l no-exec -d 'Do not execute any stored pre- or post-uninstall procedures'
#
# # unlink
# complete -f -c port -n '__fish_port_needs_command' -a unlink -d 'Unlink formula'
# complete -c port -n '__fish_port_using_command unlink' -a '(__fish_port_installed)'
#
# # update
# complete -f -c port -n '__fish_port_needs_command' -a update -d 'Fetch newest version of Homeport and formulas'
# complete -f -c port -n '__fish_port_using_command update' -l rebase -d 'Use git pull --rebase'
#
# # upgrade
complete -f -c port -n '__fish_port_needs_command' -a upgrade -d 'Upgrade outdated ports'
complete -f -c port -n '__fish_port_using_command upgrade' -a "$pseudo_portnames" -d 'pseudo portname'
complete -x -c port -n '__fish_port_using_command upgrade' -a "(__fish_port_outdated_formulas)" -d 'outdated portname'
#
# # uses
# complete -f -c port -n '__fish_port_needs_command' -a uses -d 'Show formulas that depend on specified formula'
# complete -f -c port -n '__fish_port_using_command uses' -l installed -d 'List only installed formulae'
# complete -c port -n '__fish_port_using_command uses' -a '(__fish_port_list)'
#
# # versions
# complete -f -c port -n '__fish_port_needs_command' -a versions -d 'List previous versions of formula'
# complete -f -c port -n '__fish_port_using_command versions' -l compact -d 'Show all options on a single line'
# complete -c port -n '__fish_port_using_command versions' -a '(__fish_port_list)'
#
#
# ############
# # switches #
# ############
# complete -f -c port -n '__fish_port_needs_command' -a '-v --version' -d 'Print version number of port'
# complete -f -c port -n '__fish_port_needs_command' -l repository -x -d 'Display where Homeport\'s .git directory is located'
# complete -f -c port -n '__fish_port_needs_command' -l config -x -d 'Show Homeport and system configuration'
#
# # --prefix
# complete -f -c port -n '__fish_port_needs_command' -l prefix -d 'Display Homeport\'s install path'
# complete -f -c port -n '__fish_port_using_command --prefix' -a '(__fish_port_list)' -d 'Display formula\'s install path'
#
# # --cache
# complete -f -c port -n '__fish_port_needs_command' -l cache -d 'Display Homeport\'s download cache'
# complete -f -c port -n '__fish_port_needs_command' -n '__fish_port_using_command --cache' -a '(__fish_port_list)' -d 'Display the file or directory used to cache formula'
#
# # --cellar
# complete -f -c port -n '__fish_port_needs_command' -l cellar -d 'Display Homeport\'s Cellar path'
# complete -f -c port -n '__fish_port_using_command --cellar' -a '(__fish_port_list)' -d 'Display formula\'s install path in Cellar'
#
