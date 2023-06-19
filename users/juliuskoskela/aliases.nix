{
  # Nix commands
  rebuild = "sudo nixos-rebuild --flake '.#'$(hostname) switch --impure";

  # Git
  stage = "git add";
  commit = "git commit -s -S";
  push = "git push";

  # Editor
  edit = "$EDITOR";

  # Shortcuts
  repos = "cd ~/Repos";
  nixos = "cd ~/Repos/nixos";

  mail = "protonmail-bridge &";
}
