# users/juliuskoskela/default.nix
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

    description = "Julius Koskela's personal user.";

    sopsConfig = {
      age.keyFile = "/home/juliuskoskela/.secrets/age/age.key";
      defaultSopsFile = "./secrets.yaml";
    };

    gitConfig = {
      name = "Julius Koskela";
      email = "me@juliuskoskela.dev";
      gpgSignkey = "8539EF4CE6367B81";
    };

    userImports = [
      (inputs.common.programs.zsh {inherit pkgs shellAliases;})
      inputs.common.programs.nixvim
      (inputs.common.programs.alacritty {inherit colorScheme;})
    ];
  }
