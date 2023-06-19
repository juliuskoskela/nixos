# users/juliuskoskela/default.nix
{
  inputs,
  pkgs,
  ...
}: let
  shellAliases = import ./aliases.nix;
  colorScheme = inputs.nix-colors.colorSchemes.tokyo-night-dark;
  sessionVariables = import ./environment.nix;
  extraPackages = import ./packages.nix pkgs;
in
  inputs.kven.mkUser {
    inherit inputs pkgs shellAliases colorScheme sessionVariables extraPackages;

    name = "juliuskoskela";
    description = "Julius Koskela's personal user.";
    gitConfig = {
      name = "Julius Koskela";
      email = "me@juliuskoskela.dev";
      gpgSignkey = "8539EF4CE6367B81";
    };

    userImports = [
      (inputs.kven.programs.zsh {inherit pkgs shellAliases;})
      inputs.kven.programs.nixvim
      (inputs.kven.programs.alacritty {inherit colorScheme;})
    ];
  }
