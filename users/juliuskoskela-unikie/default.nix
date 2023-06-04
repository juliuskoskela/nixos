{ state-version, pkgs, ... }:
{
	fonts.fontconfig.enable = true;

	home.stateVersion = state-version;
	home.username = "juliuskoskela-unikie";
	home.homeDirectory = "/home/juliuskoskela-unikie";
	home.sessionVariables = import ./environment.nix;
	home.packages = import ./packages.nix pkgs;

	programs = import ./programs.nix;
	services = import ./services.nix;
}