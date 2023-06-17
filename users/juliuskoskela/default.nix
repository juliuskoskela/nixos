{ state-version, config, pkgs, ... }:
let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/pta2002/nixvim";
    rev = "cae34a7b8f83293b21c1c0981ba810883719dfe0";
    ref = "refs/heads/nixos-23.05";
  });
in
{
  imports = [
    # For home-manager
    nixvim.homeManagerModules.nixvim
    # For NixOS
    # nixvim.nixosModules.nixvim
  ];
  nixpkgs.config = {
    allowUnfree = true;
    # TODO! Required by nixvim and Copilot, remove if Copilot is udpated
    # to use the new version of nodejs.
    permittedInsecurePackages = [
      "nodejs-16.20.0"
    ];
  };
  fonts.fontconfig.enable = true;

  home.stateVersion = state-version;
  home.username = "juliuskoskela";
  home.homeDirectory = "/home/juliuskoskela";
  home.sessionVariables = import ./environment.nix;
  home.packages = import ./packages.nix pkgs;

  programs = import ./programs.nix pkgs;
  services = import ./services.nix;
}
