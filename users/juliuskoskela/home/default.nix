# users/juliuskoskela/home/default.nix
{
  inputs,
  pkgs,
  ...
}: let
  sessionVariables = import ./environment.nix;
  colorScheme = inputs.nix-colors.colorSchemes.dracula;
in {
  inherit colorScheme;

  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.nix-colors.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
    inputs.kven.programs.zsh
    inputs.kven.programs.nixvim
    inputs.kven.programs.alacritty
    # inputs.kven.programs.hyprland {inherit inputs;}
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

  home = {
    stateVersion = inputs.stateVersion;
    username = "juliuskoskela";
    homeDirectory = "/home/juliuskoskela";
    sessionVariables = sessionVariables;
    packages = import ./packages.nix pkgs;
  };

  programs = {
    git = {
      enable = true;
      userName = "Julius Koskela";
      userEmail = "me@juliuskoskela.dev";

      extraConfig = {
        commit.gpgsign = true;
        user.signingkey = "8539EF4CE6367B81";
      };
    };

    helix = {
      enable = true;
      settings.theme = "onedark";
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  };
}
