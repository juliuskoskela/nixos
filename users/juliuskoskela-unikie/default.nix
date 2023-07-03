# users/juliuskoskela-unikie/default.nix
{
  inputs,
  pkgs,
  system,
  ...
}: let
  shellAliases = import ./aliases.nix;
  colorScheme = inputs.nix-colors.colorSchemes.dracula;
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

    description = "Julius Koskela's professional user (Unikie)";

    sopsConfig = {
      age.keyFile = "/home/juliuskoskela/.secrets/age/age.key";
      defaultSopsFile = "./secrets.yaml";
    };

    gitConfig = {
      name = "Julius Koskela";
      email = "julius.koskela@unikie.com";
      gpgSignkey = "D5C22DF4D8242BBE";
    };

    userImports = [
      (inputs.common.programs.zsh {inherit pkgs shellAliases;})
      inputs.common.programs.nixvim
      inputs.common.programs.kitty
      inputs.common.programs.wofi
      (inputs.common.programs.alacritty {inherit colorScheme;})
    ];
  }
