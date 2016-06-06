

function   __fish_flatpak_command
  set -l cmdline (commandline -poc)
  set -e cmdline[1]
  set -l lasttoken ""
  for token in $cmdline
    if string match -r -q -- "-v|--verbose|--version"
      set lasttoken $token
      continue
    end

    echo $token
    return 0
  end

  # no command found
  return 1
end

function __fish_flatpak_subcommand --argument-names cmd
  if set -l token (__fish_flatpak_command)
    string match -q -- $token $cmd
    return 0
  else
    return 1
  end
end

for cmd in  install update uninstall list info run override export-file enter remote-add remote-modify remote-delete remote-list remote-ls build-init build build-finish build-export build-bundle build-import-bundle build-sign build-update-repo

  complete -c flatpak -n "not __fish_flatpak_subcommand" -xa $cmd
end

# flatpak
complete -c flatpak -s h -l help -d "Show help options and exit."
complete -c flatpak -s v -l verbose -d "Print debug information during command processing."
complete -c flatpak -l version -d "Print version information and exit."


# install
complete -c flatpak -n "__fish_flatpak_command install" -l bundle -d "Install from a bundle file instead of a configured remote."
complete -c flatpak -n "__fish_flatpak_command install" -l user -d "Create a per-user installation."
complete -c flatpak -n "__fish_flatpak_command install" -l system -d "Create a system-wide installation."
complete -c flatpak -n "__fish_flatpak_command install" -l arch -d "The architecture to install for."
complete -c flatpak -n "__fish_flatpak_command install" -l subpath -d "Install only a subpath of the ref."
complete -c flatpak -n "__fish_flatpak_command install" -l no-deploy -d "Don't download the latest version and don't deploy it."
complete -c flatpak -n "__fish_flatpak_command install" -l no-pull -d "Don't download the latest version but deploy it."
complete -c flatpak -n "__fish_flatpak_command install" -l app -d "Only look for an app with the given name."
complete -c flatpak -n "__fish_flatpak_command install" -l runtime -d "Only look for an runtime with the given name."

