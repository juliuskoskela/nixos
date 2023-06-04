{
	# General
	del = "rm -r";
	fdel = "rm -rf";

	# Update NixOS
	update-system = "sudo nixos-rebuild switch";
	update-home = "home-manager build && home-manager switch";

	# Git
	stage = "git add";
	commit = "git commit -s -S";
	push = "git push";

	# Editor
	edit = "$EDITOR";

	# Configuration shortcuts
	conf-system = "sudo nvim /etc/nixos/configuration.nix";
	conf-home = "nvim ~/.config/nixpkgs/home.nix";
	conf-zsh = "nvim ~/.config/nixpkgs/zsh.nix";
	conf-aliases = "nvim ~/.config/nixpkgs/shell-aliases.nix";
	conf-git = "nvim ~/.config/nixpkgs/git.nix";
	conf-nvim = "nvim ~/.config/nixpkgs/nvim.nix";
	conf-packages = "nvim ~/.config/nixpkgs/packages.nix";
	conf-programs = "nvim ~/.config/nixpkgs/programs.nix";
	conf-services = "nvim ~/.config/nixpkgs/services.nix";
	conf-env = "nvim ~/.config/nixpkgs/env.nix";

	mail = "protonmail-bridge &";
}