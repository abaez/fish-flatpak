# v0.6.6


# the commands
set __fish_flatpak_subcommands install update uninstall list info run \
  override export-file enter remote-add remote-modify remote-delete   \
  remote-list remote-ls build-init build build-finish build-export    \
  build-bundle build-import-bundle build-sign build-update-repo

complete -c flatpak -xn "__fish_use_subcommand" -a "$__fish_flatpak_subcommands"

# flatpak
complete -xc flatpak -s h -l help -d "Show help options and exit."
complete -xc flatpak -s v -l verbose -d "Print debug information during command processing."
complete -xc flatpak -l version -d "Print version information and exit."

# command sub commands: cmd [list of commands]
function __fish_flatpak_samesub
  set -l cmd $argv[1]

  for sub in $argv[2..-1]
    switch $sub
      case user
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "$cmd a per-user installation."
      case system
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "$cmd a system-wide installation."
      case arch
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "The architecture to install for."
      case subpath
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "$cmd only a subpath of the ref."
      case no-deploy
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "Don't download the latest version, but don't deploy it."
      case no-pull
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "Don't download the latest version but deploy it."
      case app
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "Only look for an app with the given name."
      case runtime
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "Only look for an runtime with the given name."
    end
  end
end

# install
complete -c flatpak -xn "__fish_seen_subcommand_from install" -l bundle -d "Install from a bundle file instead of a configured remote."
__fish_flatpak_samesub install user system arch subpath no-deploy no-pull app runtime

# update
complete -c flatpak -xn "__fish_seen_subcommand_from update" -l commit -d "Update to this commit, instead of the tip of the branch."
__fish_flatpak_samesub update user system arch subpath no-doploy no-pull app runtime

# uninstall
complete -c flatpak -xn "__fish_seen_subcommand_from uninstall" -l keep-ref -d "Keep the ref for the application and the objects belonging to it in the local repository."
__fish_flatpak_samesub uninstall user system arch app runtime

# list
complete -c flatpak -xn "__fish_seen_subcommand_from list" -l show-details -d "Show arches and branches, in addition to the application names."
__fish_flatpak_samesub list user system app runtime

# info
complete -c flatpak -xn "__fish_seen_subcommand_from info" -s r -l show-ref -d "Show the installed ref."
complete -c flatpak -xn "__fish_seen_subcommand_from info" -s o -l show-origin -d "Show the remote ref installed from."l
complete -c flatpak -xn "__fish_seen_subcommand_from info" -s c -l show-commit -d "Show the installed commit id."
__fish_flatpak_samesub info user system app runtime

# run
complete -c flatpak -xn "__fish_seen_subcommand_from run" -l "command" -d "The command to run instead of the one listed in app metadata."
complete -c flatpak -xn "__fish_seen_subcommand_from run" -l branch -d "The branch to use"
complete -c flatpak -xn "__fish_seen_subcommand_from run" -l runtime-version -d "Use version runtime instead"
complete -c flatpak -xn "__fish_seen_subcommand_from run" -l persist -d "make relative persistent bind mount"
complete -c flatpak -xn "__fish_seen_subcommand_from run" -l log-session -d "Log session bus traffic"
complete -c flatpak -xn "__fish_seen_subcommand_from run" -l log-system -d "Log system bus traffic"
__fish_flatpak_samesub run arch runtime

# run & override
for sub in run override
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -s d -l devel -d "Use devel $subtime"
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l share -d "Share a subsystem with host session."
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l unshare -d "Don't share a subsystem with host.'"
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l socket -d "Expose a socket to the app."
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l nosocket -d "Don't eExpose a socket to the app."
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l device -d "Expose a device to the app."
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l nodevice -d "Don't eExpose a device to the app."
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l filesystem -d "Allow the app access to a subnet of the fs."
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l env -d "Set an env var for the app."
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l own-name -d "Allow the app to own the name in the session bus"
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l talk-name -d "Allow the app to talk the name in the session bus"
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l system-own-name -d "Allow the app to own the name in the system bus"
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l system-talk-name -d "Allow the app to talk the name in the system bus"
end


# export-file
complete -c flatpak -xn "__fish_seen_subcommand_from export-file" -xa app -l  allow-write -d "Also grant write access to the applications specified with --app."
complete -c flatpak -xn "__fish_seen_subcommand_from export-file" -xa app -l  allow-delete -d "Also grant the ability to delete a document id to the applications specified with --app."
complete -c flatpak -xn "__fish_seen_subcommand_from export-file" -xa app -l  allow-grant-permission -d "Also grant the ability to further grant permissions for applications specified with --app."
complete -c flatpak -xn "__fish_seen_subcommand_from export-file" -l unique -d "Don't reuese an existing document id for the file."
complete -c flatpak -xn "__fish_seen_subcommand_from export-file" -l transient -d "The document will only exist for the length of the session."
__fish_flatpak_samesub list app


#----------------
# remote

### add

### modify

### delete

### list

### ls

#----------------
# build

### init

### finish

### export

### bundle

### import-bundle

### update-repo

### sign



