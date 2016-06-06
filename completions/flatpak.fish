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

# flatpak
complete -c flatpak -s h -l help -d "Show help options and exit."
complete -c flatpak -s v -l verbose -d "Print debug information during command processing."
complete -c flatpak -l version -d "Print version information and exit."
