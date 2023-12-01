# users/juliuskoskela/default.nix
{
  inputs,
  pkgs,
  system,
  ...
}: let
  shellAliases = import ./aliases.nix;
  colorScheme = inputs.nix-colors.colorSchemes.tokyo-night-dark;
  sessionVariables = import ./environment.nix;
  extraPackages = import ./packages.nix pkgs;
in
  inputs.common.mkUser {
    inherit
      inputs
      pkgs
      system
      shellAliases
      colorScheme
      sessionVariables
      extraPackages
      ;

    name = "juliuskoskela";

    description = "Julius Koskela's personal user.";

    gitConfig = {
      name = "Julius Koskela";
      email = "me@juliuskoskela.dev";
      gpgSignkey = "F8D04B433A9B977E";
    };

    userImports = [
      (inputs.common.programs.zsh {inherit pkgs shellAliases;})
      inputs.common.programs.nixvim
      inputs.common.programs.kitty
      inputs.common.programs.wofi
      # inputs.common.programs.rofi
      # inputs.common.programs.scripts
      # inputs.common.programs.eww
      (inputs.common.programs.alacritty {inherit colorScheme;})
    ];
  }
