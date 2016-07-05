# v0.6.6


# the commands
set __fish_flatpak_subcommands install update uninstall list info run \
  override document-export enter remote-add remote-modify remote-delete   \
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
      # set for run, override, build
      case devel
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "Use devel $subtime"
      case share
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "Share a subsystem with host session."
      case unshare
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "Don't share a subsystem with host."
      case socket
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "Expose a socket to the app."
      case nosocket
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "Don't eExpose a socket to the app."
      case device
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "Expose a device to the app."
      case nodevice
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "Don't eExpose a device to the app."
      case filesystem
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "Allow the app access to a subnet of the fs."
      case env
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "Set an env var for the app."
      case own-name
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "Allow the app to own the name in the session bus"
      case talk-name
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "Allow the app to talk the name in the session bus"
      case system-own-name
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "Allow the app to own the name in the system bus"
      case system-talk-name
        complete -c flatpak -xn "__fish_seen_subcommand_from $cmd" -l $sub -d "Allow the app to talk the name in the system bus"
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
__fish_flatpak_samesub run arch runtime devel share unshare socket nosocket \
  device nodevice filesystem env own-name talk-name system-own-name system-talk-name

# override
__fish_flatpak_samesub override devel share unshare socket nosocket device \
  nodevice filesystem env own-name talk-name system-own-name system-talk-name



#----------------
# document

### export
complete -c flatpak -xn "__fish_seen_subcommand_from document-export" -l unique -d "Don't reuese an existing document id for the file."
complete -c flatpak -xn "__fish_seen_subcommand_from document-export" -l transient -d "The document will only exist for the length of the session."
complete -c flatpak -xn "__fish_seen_subcommand_from document-export" -xa app -l  allow-write -d "Also grant write access to the applications specified with --app."
complete -c flatpak -xn "__fish_seen_subcommand_from document-export" -xa app -l  forbid-write -d "Forbid write access to the applications specified with --app."
complete -c flatpak -xn "__fish_seen_subcommand_from document-export" -xa app -l  allow-read -d "Also grant the ability to read a document id to the applications specified with --app."
complete -c flatpak -xn "__fish_seen_subcommand_from document-export" -xa app -l  forbid-read -d "Also disallow the ability to read a document id to the applications specified with --app."
complete -c flatpak -xn "__fish_seen_subcommand_from document-export" -xa app -l  allow-delete -d "Also grant the ability to delete a document id to the applications specified with --app."
complete -c flatpak -xn "__fish_seen_subcommand_from document-export" -xa app -l  forbid-delete -d "Forbid the ability to delete a document id to the applications specified with --app."
complete -c flatpak -xn "__fish_seen_subcommand_from document-export" -xa app -l  allow-grant-permission -d "Also grant the ability to further grant permissions for applications specified with --app."
complete -c flatpak -xn "__fish_seen_subcommand_from document-export" -xa app -l  forbid-grant-permission -d "Forbid the ability to further grant permissions for applications specified with --app."
__fish_flatpak_samesub document-export app

### unexport
### info
### list

#----------------
# remote

### add, modify
for sub in add modify
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l no-gpg-verify -d "Disable GPG verification for remote."
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l prio -d "Set the priority for the remote."
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l no-enumerate -d "Mark the remote as not enumerated."
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l "if-not-exists" -d "Do nothing if the provided remote already exists."
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l disable -d "Disable the added remote."
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l title -d "A title for the remote."
  complete -c flatpak -xn "__fish_seen_subcommand_from $sub" -l gpg-import -d "Import the specified gpg keys."
end
__fish_flatpak_samesub remote-add user system
__fish_flatpak_samesub remote-modify user system

### delete
complete -c flatpak -xn "__fish_seen_subcommand_from remote-delete" -l force -d "Remove remote by force."
__fish_flatpak_samesub remote-delete user system

### list
complete -c flatpak -xn "__fish_seen_subcommand_from remote-list" -l show-details -d "Show more information of each repo."
complete -c flatpak -xn "__fish_seen_subcommand_from remote-list" -l show-disabled -d "Show disabled repos."
__fish_flatpak_samesub remote-list user system

### ls
complete -c flatpak -xn "__fish_seen_subcommand_from remote-ls" -s d -l show-details -d "Show arches, branches, and commits."
complete -c flatpak -xn "__fish_seen_subcommand_from remote-ls" -l updates -d "Show only updates available."
__fish_flatpak_samesub remote-ls user system runtime app arch


#----------------
# build
complete -c flatpak -xn "__fish_seen_subcommand_from build" -s r -l runtime -d "Use non-devel runtime of app metadata."
complete -c flatpak -xn "__fish_seen_subcommand_from build" -l build-mount -d "Add a custom bind mount in the build namespace."
complete -c flatpak -xn "__fish_seen_subcommand_from build" -l build-dir -d "Start the build in directory."
complete -c flatpak -xn "__fish_seen_subcommand_from build" -l share -d "Share a subsystem with the host session."
complete -c flatpak -xn "__fish_seen_subcommand_from build" -l unshare -d "Unshare a subsystem with the host session."
complete -c flatpak -xn "__fish_seen_subcommand_from build" -l socket -d "Expose a well-known socket to the app."
complete -c flatpak -xn "__fish_seen_subcommand_from build" -l nosocket -d "Unexpose a well-known socket to the app."
complete -c flatpak -xn "__fish_seen_subcommand_from build" -l device -d "Expose a device to the app."
complete -c flatpak -xn "__fish_seen_subcommand_from build" -l nodevice -d "Unexpose a device to the app."
complete -c flatpak -xn "__fish_seen_subcommand_from build" -l filesystem -d "Allow the app access to a subset of the fs."
complete -c flatpak -xn "__fish_seen_subcommand_from build" -l nofilesystem -d "Disallow the app access to a subset of the fs."
complete -c flatpak -xn "__fish_seen_subcommand_from build" -l env -d "Set an env var in the app."
complete -c flatpak -xn "__fish_seen_subcommand_from build" -l own-name -d "Allow the app to own a name in session bus."
complete -c flatpak -xn "__fish_seen_subcommand_from build" -l talk-name -d "Allow the app to talk to a name in session bus."

### init

### finish

### export

### bundle

### import-bundle

### update-repo

### sign



