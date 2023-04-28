{ config, pkgs, ... }:
let
	userPackages = import ./packages.nix;
	userServices = import ./services.nix;
	userPrograms = import ./programs.nix;
	userEnvVars  = import ./env.nix;
in
{
	nixpkgs.config.allowUnfree = true;

	home.stateVersion = "22.11";
	home.username = "juliuskoskela";
	home.homeDirectory = "/home/juliuskoskela";
	home.sessionVariables = userEnvVars pkgs;
	home.packages = userPackages pkgs;

	programs = userPrograms pkgs;
	services = userServices pkgs;
}