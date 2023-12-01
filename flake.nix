# flake.nix
#
{
  description = "NixOS system configurations";

  inputs = {
    # Nixpkgs is a comprehensive collection of packages, package definitions,
    # and build infrastructure used by Nix and NixOS. It provides a wide range
    # of pre-built packages for various purposes, including system utilities,
    # programming languages, libraries, desktop environments, and applications.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home-manager is a powerful tool for managing user-specific configurations
    # using the Nix package manager. It allows users to declaratively define
    # and manage their shell configuration, environment variables, editor
    # settings, and more, providing a consistent and reproducible environment
    # across different systems.
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
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
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-colors helps with creating system-wide color templates for Nix.
    nix-colors.url = "github:misterio77/nix-colors";

    # Terminal file manager.
    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dnglab = {
      url = "github:juliuskoskela/dnglab";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    microvm,
    hyprland,
    hyprwm-contrib,
    nixvim,
    nix-colors,
    yazi,
    dnglab,
  } @ flake-inputs: let
    inputs =
      flake-inputs
      // {
        stateVersion = "23.11";
        common = import ./common {inherit inputs;};
      };
  in {
    # The nixosConfigurations attribute in the flake.nix file defines
    # different NixOS system configurations that can be built using the
    # mkNixos function from the lib library.
    nixosConfigurations = {
      vega = inputs.common.mkNixos [
        ./hosts/vega
        ./users/juliuskoskela
        # ./users/juliuskoskela-unikie
      ] "x86_64-linux";

      luna = inputs.common.mkNixos [
        ./hosts/luna
        ./users/juliuskoskela
        ./users/juliuskoskela-unikie
      ] "x86_64-linux";

      nova = inputs.common.mkNixos [
        ./hosts/nova
        ./users/juliuskoskela
        ./users/juliuskoskela-unikie
      ] "x86_64-linux";
    };

    devShells = inputs.common.forEachPkgs (pkgs: import ./shell.nix {inherit pkgs;});
    formatter = inputs.common.forEachPkgs (pkgs: pkgs.alejandra);
  };
}
