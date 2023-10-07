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

    # Secrets are decrypted from sops files during activation time. The secrets are
    # stored as one secret per file and access-controlled by full declarative
    # configuration of their users, permissions, and groups. GPG keys or age keys can
    # be used for decryption, and compatibility shims are supported to enable the use
    # of SSH RSA or SSH Ed25519 keys. Sops also supports cloud key management APIs
    # such as AWS KMS, GCP KMS, Azure Key Vault and Hashicorp Vault. While not
    # officially supported by sops-nix yet, these can be controlled using environment
    # variables that can be passed to sops.
    sops-nix.url = "github:Mic92/sops-nix";

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
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-colors helps with creating system-wide color templates for Nix.
    nix-colors.url = "github:misterio77/nix-colors";

    # More colors...
    base16.url = "github:SenchoPens/base16.nix";
    base16-schemes = {
      url = github:base16-project/base16-schemes;
      flake = false;
    };
    base16-zathura = {
      url = github:haozeke/base16-zathura;
      flake = false;
    };
    base16-vim = {
      url = github:base16-project/base16-vim;
      flake = false;
    };

    audio-logger = {
      url = "github:nordic-dev-net/audio-logger/1-make-audio-logger-work-as-a-systemd-service-through-the-flake";
      # follows = "nixpkgs";
    };
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
        common = import ./common {inherit inputs;};
      };
  in {
    # The nixosConfigurations attribute in the flake.nix file defines
    # different NixOS system configurations that can be built using the
    # mkNixos function from the lib library.
    nixosConfigurations = {
      # vega = inputs.common.mkNixos [
      #   ./hosts/vega
      #   ./users/juliuskoskela
      #   ./users/juliuskoskela-unikie
      # ] "x86_64-linux";

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
