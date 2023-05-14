# Configure Neovim
{
  inputs.neovim-flake.url = "github:jordanisaacs/neovim-flake";

  outputs = {nixpkgs, neovim-flake, ...}: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    configModule = {
      # Add any custom options (and feel free to upstream them!)
      # options = ...

      config.vim.theme.enable = true;
    };

    customNeovim = neovim-flake.lib.neovimConfiguration {
      modules = [configModule];
      inherit pkgs;
    };
  in {
    packages.${system}.neovim = customNeovim;
  };
}