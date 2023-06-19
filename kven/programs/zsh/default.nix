# kven/programs/zsh/default.nix
{shellAliases ? {}, ...}: {
  programs.zsh = import ./config.nix shellAliases;
}
