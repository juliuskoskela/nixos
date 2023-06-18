{
  inputs,
  pkgs,
  stateVersion,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.nix-colors.homeManagerModules.default
	../../../programs/hyprland {inherit inputs;}
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
  colorScheme = inputs.nix-colors.colorSchemes.dracula;

  home.stateVersion = stateVersion;
  home.username = "juliuskoskela";
  home.homeDirectory = "/home/juliuskoskela";
  home.sessionVariables = import ./environment.nix;
  home.packages = import ./packages.nix pkgs;

  programs = import ./programs.nix pkgs;
  services = import ./services.nix;
}
