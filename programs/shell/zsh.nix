{shell-aliases, ...}: {
  enable = true;
  shellAliases = shell-aliases;

  oh-my-zsh = {
    enable = true;
    plugins = ["git"];
    theme = "robbyrussell";
  };
}
