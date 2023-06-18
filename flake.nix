# flake.nix
#
{
  description = "NixOS system configurations";

  inputs = {
    # Nixpkgs is a comprehensive collection of packages, package definitions,
    # and build infrastructure used by Nix and NixOS. It provides a wide range
    # of pre-built packages for various purposes, including system utilities,
    # programming languages, libraries, desktop environments, and applications.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    # Home-manager is a powerful tool for managing user-specific configurations
    # using the Nix package manager. It allows users to declaratively define
    # and manage their shell configuration, environment variables, editor
    # settings, and more, providing a consistent and reproducible environment
    # across different systems.
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake-utils is a utility library specifically designed for working with
    # flakes in Nix. It offers a collection of functions and tools that assist
    # in the development and management of Nix flakes, simplifying tasks such
    # as building, testing, and deployment of flake-based projects.
    flake-utils.url = "github:numtide/flake-utils";

    # Microvm-nix is a project that provides a framework for building and
    # managing micro virtual machines (microVMs) using Nix and Firecracker.
    # It allows users to create lightweight, isolated VMs optimized for
    # running a single application or service, providing enhanced security
    # and resource efficiency compared to traditional virtual machines.
    microvm-nix = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    # Hyprland is a Wayland window manager designed for a modern, efficient,
    # and customizable user experience. It provides a lightweight and
    # composable window management solution for Wayland-based desktop
    # environments, offering features such as tiling, stacking, and
    # dynamic workspace management.
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprwm-contrib provides community scripts and utilities for Hypr
    # projects such as try_swap_workspace adn scratchpad.
    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixvim is a configuration framework for Neovim, a highly extensible
    # and customizable text editor. It provides a curated set of plugins,
    # settings, and keybindings to enhance the Neovim editing experience,
    # making it suitable for various programming languages and workflows.
    nixvim = {
      url = "github:pta2002/nixvim";
    };

    # nix-colors helps with creating system-wide color templates for Nix.
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-colors,
    hyprland,
    ...
  } @ flake-inputs: let
    # stateVersion = "23.05";
    inputs =
      flake-inputs
      // {
        stateVersion = "23.05";
        kven = import ./kven {inherit inputs;};
      };
  in {
    # The nixosConfigurations attribute in the flake.nix file defines
    # different NixOS system configurations that can be built using the
    # mkNixos function from the lib library.
    nixosConfigurations = {
      nova = inputs.kven.mkNixos [./hosts/nova];
      #   luna = inputs.kven.mkNixos [./hosts/luna];
    };

    devShells = inputs.kven.forEachPkgs (pkgs: import ./shell.nix {inherit pkgs;});
    formatter = inputs.kven.forEachPkgs (pkgs: pkgs.alejandra);
  };
}
