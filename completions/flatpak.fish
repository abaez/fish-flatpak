
# the commands
set __fish_flatpak_subcommands install update uninstall list info run \
  override export-file enter remote-add remote-modify remote-delete   \
  remote-list remote-ls build-init build build-finish build-export    \
  build-bundle build-import-bundle build-sign build-update-repo

complete -c flatpak -xc flatpak -n "__fish_use_subcommand" -a "$__fish_flatpak_subcommands"

# flatpak
complete -c flatpak -s h -l help -d "Show help options and exit."
complete -c flatpak -s v -l verbose -d "Print debug information during command processing."
complete -c flatpak -l version -d "Print version information and exit."

# command sub commands: cmd [list of commands]
function __fish_flatpak_samesub
  set -l cmd $argv[1]

  for sub in $argv[2..-1]
    switch $sub
      case user
        complete -c flatpak -x -n "__fish_seen_subcommand_from $cmd" -l $sub -d "$cmd a per-user installation."
      case system
        complete -c flatpak -x -n "__fish_seen_subcommand_from $cmd" -l $sub -d "$cmd a system-wide installation."
      case arch
        complete -c flatpak -x -n "__fish_seen_subcommand_from $cmd" -l $sub -d "The architecture to install for."
      case subpath
        complete -c flatpak -x -n "__fish_seen_subcommand_from $cmd" -l $sub -d "$cmd only a subpath of the ref."
      case no-deploy
        complete -c flatpak -x -n "__fish_seen_subcommand_from $cmd" -l $sub -d "Don't download the latest version, but don't deploy it."
      case no-pull
        complete -c flatpak -x -n "__fish_seen_subcommand_from $cmd" -l $sub -d "Don't download the latest version but deploy it."
      case app
        complete -c flatpak -x -n "__fish_seen_subcommand_from $cmd" -l $sub -d "Only look for an app with the given name."
      case runtime
        complete -c flatpak -x -n "__fish_seen_subcommand_from $cmd" -l $sub -d "Only look for an runtime with the given name."
    end
  end
end

# install
complete -c flatpak -n "__fish_seen_subcommand_from install" -l bundle -d "Install from a bundle file instead of a configured remote."
__fish_flatpak_samesub install user system arch subpath no-deploy no-pull app runtime

# update
complete -c flatpak -n "__fish_seen_subcommand_from update" -l commit -d "Update to this commit, instead of the tip of the branch."
__fish_flatpak_samesub update user system arch subpath no-doploy no-pull app runtime

# uninstall
complete -c flatpak -n "__fish_seen_subcommand_from uninstall" -l keep-ref -d "Keep the ref for the application and the objects belonging to it in the local repository."
__fish_flatpak_samesub uninstall user system arch app runtime

# list
complete -c flatpak -n "__fish_seen_subcommand_from uninstall" -l show-details -d "Show arches and branches, in addition to the application names."
__fish_flatpak_samesub list user system app runtime
