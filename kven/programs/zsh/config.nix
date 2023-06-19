# kven/programs/zsh/config.nix
shellAliases: {
  enable = true;
  shellAliases = shellAliases;

  oh-my-zsh = {
    enable = true;
    plugins = ["git"];
    theme = "robbyrussell";
  };
}
