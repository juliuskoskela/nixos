{
  pkgs,
  stateVersion,
  ...
}: {
  nixpkgs.config = {
    allowUnfree = true;
    # TODO! Required by nixvim and Copilot, remove if Copilot is udpated
    # to use the new version of nodejs.
    permittedInsecurePackages = [
      "nodejs-16.20.0"
    ];
  };
  fonts.fontconfig.enable = true;

  home.stateVersion = stateVersion;
  home.username = "juliuskoskela-unikie";
  home.homeDirectory = "/home/juliuskoskela-unikie";
  home.sessionVariables = import ./environment.nix;
  home.packages = import ./packages.nix pkgs;

  programs = import ./programs.nix pkgs;
  services = import ./services.nix;
}
