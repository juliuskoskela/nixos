# lib
#
# Reusable functions and variables for Nix expressions.
{inputs, ...}: let
  programs = {
    zsh = import ./programs/zsh;
    alacritty = import ./programs/alacritty;
    nixvim = import ./programs/nixvim;
    gnome = import ./programs/gnome;
    plasma = import ./programs/plasma;
    hyprland = import ./programs/hyprland;
    waybar = import ./programs/waybar;
  };
  # A function that generates attributes for each system architecture.
  # It takes a list of system architectures as input and returns a set of attributes
  # with each architecture as the attribute name.
  forEachSystem = inputs.nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"];

  # A function that applies a given function to each system architecture
  # and its corresponding package set. It takes a function as input and applies it to
  # each system architecture's package set, returning the result as a set of attributes.
  forEachPkgs = f: forEachSystem (sys: f (inputs.nixpkgs.legacyPackages.${sys}));

  # A function that creates a NixOS host system configuration. It takes a
  # module set as input and returns a NixOS system configuration with the provided
  # module set and additional special arguments.
  mkNixos = modules: system:
    inputs.nixpkgs.lib.nixosSystem {
      inherit modules;
      specialArgs = {inherit inputs system;};
    };

  mkUser = {
    inputs,
    pkgs,
    system,
    name,
    description,
    gitConfig,
    extraPackages ? [],
    sessionVariables ? {},
    shellAliases ? {},
    userImports ? [],
    colorScheme ? inputs.nix-colors.colorSchemes.dracula,
  }: {
    users.users.${name} = {
      isNormalUser = true;
      description = "${description}";
      extraGroups = ["networkmanager" "wheel"];
    };

    home-manager.users.${name} = {
      colorScheme = colorScheme;

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
        inherit sessionVariables;
        inherit (inputs) stateVersion;

        username = "${name}";
        homeDirectory = "/home/${name}";
        packages = extraPackages;
      };

      imports =
        [
          (inputs.common.programs.hyprland {inherit inputs pkgs sessionVariables colorScheme;})
          (inputs.common.programs.waybar {inherit system inputs pkgs sessionVariables colorScheme;})
          inputs.nixvim.homeManagerModules.nixvim
          inputs.nix-colors.homeManagerModules.default
        ]
        ++ userImports;

      programs.git = mkGitUser gitConfig;

      services = {
        gpg-agent = {
          enable = true;
          defaultCacheTtl = 1800;
          enableSshSupport = true;
        };
      };
    };
  };

  mkGitUser = gitConfig: {
    enable = true;
    userName = "${gitConfig.name}";
    userEmail = "${gitConfig.email}";

    extraConfig = {
      commit.gpgsign = true;
      user.signingkey = "${gitConfig.gpgSignkey}";
    };
  };
in {
  inherit programs forEachSystem forEachPkgs mkNixos mkUser mkGitUser;
}
