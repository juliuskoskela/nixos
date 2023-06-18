# lib
#
# Reusable functions and variables for Nix expressions.
{inputs, ...}: let
  programs = import ./programs;
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
  mkNixos = modules:
    inputs.nixpkgs.lib.nixosSystem {
      inherit modules;
      specialArgs = {inherit inputs;};
    };

  mkGitUser = userName: userEmail: gpgPubKey: {
    programs.git = {
      enable = true;
      userName = "${userName}";
      userEmail = "${userEmail}";

      extraConfig = {
        commit.gpgsign = true;
        user.signingkey = "${gpgPubKey}";
      };
    };
  };
in {
  inherit programs forEachSystem forEachPkgs mkNixos mkGitUser;
}
