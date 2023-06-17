{
  # Update NixOS
  system-update = "sudo nixos-rebuild switch";
  system-upgrade = "sudo nixos-rebuild switch";

  # Git
  stage = "git add";
  commit = "git commit -s -S";
  push = "git push";

  # Editor
  edit = "$EDITOR";

  # Shortcuts
  repos = "cd ~/Repos";
  configs = "cd ~/Repos/nixos";

  mail = "protonmail-bridge &";
}
