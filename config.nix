# configuration.nix
#
# Main NixOS configuration file
#
# Symlink this file to /etc/nixos/configuration.nix
#
# $ sudo ln -s configuration.nix /etc/nixos/configuration.nix
#
# Then run the following command to activate the configuration:
#
# $ sudo nixos-rebuild switch

{ config, pkgs, ... }:
{
	imports = [ ./hardware-configuration.nix ];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.loader.efi.efiSysMountPoint = "/boot/efi";

	hardware.bluetooth.enable = true;

	# Required for Steam
	hardware.opengl.driSupport32Bit = true;

	services.blueman.enable = true;

	networking.hostName = "nixos";

	# Enable networking
	networking.networkmanager.enable = true;

	# Set your time zone.
	time.timeZone = "Europe/Helsinki";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
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

	# Enable the Gnome Desktop Environment.
	services.xserver = {
		enable = true;
		displayManager.gdm.enable = true;
		desktopManager.gnome.enable = true;
		windowManager.i3 = {
			enable = true;
			package = pkgs.i3-gaps;
		};
		layout = "us,fi";
		xkbVariant = "";
	};
	programs.dconf.enable = true;

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Enable sound with pipewire.
	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.juliuskoskela = {
		isNormalUser = true;
		description = "Julius Koskela";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.zsh;
	};

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		neovim
		wget
		curl
		pkg-config
		openssl
		python
		helix
	];

	# Enable the OpenSSH daemon.
	services.openssh.enable = true;

	system.stateVersion = "22.11";

}
