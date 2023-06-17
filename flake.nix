{
  description = "Nixtro-42";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    home-manager = {
		url = "github:nix-community/home-manager/release-23.05";
		inputs.nixpkgs.follows = "nixpkgs";
	};
	flake-utils.url = "github:numtide/flake-utils";
	microvm-nix = {
		url = "github:astro/microvm-nix";
		inputs.nixpkgs.follows = "nixpkgs";
		inputs.flake-utils.follows = "flake-utils";
	};
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: {

	# nixosConfigurations is a set of NixOS configurations that represent
	# different host systems.
    nixosConfigurations = {

	  # Home desktop
      nova = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./hosts/nova
        ];
      };

	  # Work laptop
      luna = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./hosts/luna
        ];
      };
    };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
