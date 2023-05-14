{ config, pkgs, ... }:
let
	userPackages = import ./packages.nix;
	userServices = import ./services.nix;
	userPrograms = import ./programs.nix;
	userEnv      = import ./env.nix;
	userWM	     = import ./configs/i3.nix;
in
{
	nixpkgs.config.allowUnfree = true;
	fonts.fontconfig.enable = true;
	# gtk = {
	# 	enable = true;

	# 	iconTheme = {
	# 		name = "WhiteSur";
	# 		package = pkgs.whitesur-icon-theme;
	# 	};
	# 	theme = {
	# 		name = "WhiteSur";
	# 		package = pkgs.whitesur-gtk-theme;
	# 	};
	# 	gtk3.extraConfig = { Settings = ''gtk-application-prefer-dark-theme=1''; };
	# 	gtk4.extraConfig = { Settings = ''gtk-application-prefer-dark-theme=1''; };
	# };

	home.stateVersion = "22.11";
	home.username = "juliuskoskela";
	home.homeDirectory = "/home/juliuskoskela";
	# home.sessionVariables.GTK_THEME = "WhiteSur";
	home.sessionVariables = userEnv pkgs;
	home.packages = userPackages pkgs;

	programs = userPrograms pkgs;
	services = userServices pkgs;
}