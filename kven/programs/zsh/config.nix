# kven/programs/zsh/config.nix
{
  enable = true;
  shellAliases = {
    rebuild = "sudo nixos-rebuild --flake '.#'$(hostname) switch --impure";
    stage = "git add";
    commit = "git commit -s -S";
    push = "git push";
    edit = "$EDITOR";
    repos = "cd ~/Repos";
    configs = "cd ~/Repos/nixos";
    mail = "protonmail-bridge &";
  };

  oh-my-zsh = {
    enable = true;
    plugins = ["git"];
    theme = "robbyrussell";
  };
}
