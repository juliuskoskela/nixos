pkgs: with pkgs; [

	# Browser
	firefox

	# Window Manager GUI
	rofi
	feh

	# Editors
	vscode
	lapce

	# Communication
	zulip
	slack
	discord
	whatsapp-for-linux
	thunderbird
	protonmail-bridge
	neomutt

	# Tools
	nextcloud-client
	gh
	curl
	wget
	python
	appimage-run

	# Entertainment
	steam
	spotify

	# Security
	gnupg
	keeweb

	# Development
	gcc
	gnumake

	# Audio
	bitwig-studio
	audacity

	# Photo
	gimp
	inkscape
	darktable

	# Financlial
	hledger

	# Fonts
	(nerdfonts.override { fonts = [
		"FiraCode"
		"DroidSansMono"
		"JetBrainsMono"
	];})

	# Gnome Extensions
	gnomeExtensions.user-themes
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.vitals
    gnomeExtensions.dash-to-panel
    gnomeExtensions.sound-output-device-chooser
    gnomeExtensions.space-bar
]