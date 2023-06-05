###############################################################################
#
# Main NixOS configuration file

{ config, pkgs, ... }:
let
	state-version = "23.05";
	home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${state-version}.tar.gz";
in
{
	imports = [
		/etc/nixos/hardware-configuration.nix
		(import "${home-manager}/nixos")
	];

	###########################################################################
	#
	# System, hardware and boot

	system.stateVersion = state-version;
	hardware = {
		bluetooth.enable = true;
		opengl.driSupport32Bit = true;	# Required for Steam
		pulseaudio.enable = false;
	};
	boot = {
		loader.systemd-boot.enable = true;
		loader.efi.canTouchEfiVariables = true;
		loader.efi.efiSysMountPoint = "/boot/efi";
	};

	###########################################################################
	#
	# Nix

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs.config.allowUnfree = true;

	###########################################################################
	#
	# Users

	users.users = {
		juliuskoskela = {
			isNormalUser = true;
			description = "Julius Koskela";
			extraGroups = [ "networkmanager" "wheel" ];
		};
		juliuskoskela-unikie = {
			isNormalUser = true;
			description = "Julius Koskela (Unikie)";
			extraGroups = [ "networkmanager" "wheel" ];
		};
	};
	home-manager.users = {
		juliuskoskela = import ./users/juliuskoskela { inherit state-version pkgs; };
		juliuskoskela-unikie = import ./users/juliuskoskela-unikie { inherit state-version config pkgs; };
	};

	###########################################################################
	#
	# Services

	services = {
		blueman.enable = true;
		xserver = import ./programs/desktop/gnome.nix { inherit config pkgs; };
		printing.enable = true;
		openssh.enable = true;
		pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
		};
	};

	###########################################################################
	#
	# Networking

	networking = {
		hostName = "nixos";
		networkmanager.enable = true;
	};

	###########################################################################
	#
	# Time and locale

	time = {
		timeZone = "Europe/Helsinki";
	};
	i18n = {
		defaultLocale = "en_US.UTF-8";
		extraLocaleSettings = {
			LC_ADDRESS = "fi_FI.UTF-8";
			LC_IDENTIFICATION = "fi_FI.UTF-8";
			LC_MEASUREMENT = "fi_FI.UTF-8";
			LC_MONETARY = "fi_FI.UTF-8";
			LC_NAME = "fi_FI.UTF-8";
			LC_NUMERIC = "fi_FI.UTF-8";
			LC_PAPER = "fi_FI.UTF-8";
			LC_TELEPHONE = "fi_FI.UTF-8";
			LC_TIME = "fi_FI.UTF-8";
		};
	};

	###########################################################################
	#
	# Programs

	programs.dconf.enable = true;

	###########################################################################
	#
	# Sound

	sound.enable = true;

	###########################################################################
	#
	# Security

	security.rtkit.enable = true;

	###########################################################################
	#
	# Root environment

	environment = {
		systemPackages = with pkgs; [
			neovim
			wget
			curl
			pkg-config
			openssl
			# python
			helix
		];
	};
}
