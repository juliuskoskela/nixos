# users/juliuskoskela/default.nix
{
  inputs,
  pkgs,
  ...
}: let
  shellAliases = import ./aliases.nix;
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
  sessionVariables = import ./environment.nix;
  extraPackages = import ./packages.nix pkgs;
in
  inputs.common.mkUser {
    inherit inputs pkgs shellAliases colorScheme sessionVariables extraPackages;

    name = "juliuskoskela";
    description = "Julius Koskela's work user on Luna.";
    gitConfig = {
      name = "Julius Koskela";
      email = "julius.koskela@unikie.com";
      gpgSignkey = "F59CC7164834F73C";
    };

    userImports = [
      (inputs.common.programs.zsh {inherit pkgs shellAliases;})
      inputs.common.programs.nixvim
      (inputs.common.programs.alacritty {inherit colorScheme;})
    ];
  }
