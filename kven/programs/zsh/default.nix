# kven/programs/zsh/default.nix
{
  pkgs,
  shellAliases ? {},
  ...
}: {
  programs.zsh = import ./config.nix {inherit pkgs shellAliases;};
}
