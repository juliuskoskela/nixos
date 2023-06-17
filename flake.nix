{
  description = "My NixOS configuration";
  inputs = rec {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager?rev=release-23.05";
  };
  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations = {
      desktop1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          {
            configuration = import ./hosts/desktop-1 { inherit nixpkgs home-manager; };
          }
        ];
      };
    };
  };
}
