# users/default.nix
{
  inputs,
  pkgs,
  ...
}: let
  juliuskoskela = import ./juliuskoskela;
in {
  inherit juliuskoskela;
}
