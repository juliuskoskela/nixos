{
  # Keyboard layout
  fi = "hyprctl keyword input:kb_layout fi";
  en = "hyprctl keyword input:kb_layout us";

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
  configs = "cd ~/Repos/nixos";

  mail = "protonmail-bridge &";
}
