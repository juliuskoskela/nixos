# users/juliuskoskela/default.nix
{
  inputs,
  pkgs,
  #   config,
  ...
}: let
  shellAliases = import ./home/shell-aliases.nix;
  colorScheme = inputs.nix-colors.colorSchemes.dracula;
  sessionVariables = import ./home/environment.nix;
  extraPackages = import ./home/packages.nix pkgs;
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
      (inputs.kven.programs.zsh shellAliases)
      inputs.kven.programs.nixvim
      inputs.kven.programs.alacritty
    ];
  }
