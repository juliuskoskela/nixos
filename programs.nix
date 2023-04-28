pkgs:
let
	nvimConfig = import ./nvim.nix;
	zshConfig = import ./zsh.nix;
	gitConfig = import ./git.nix;
	alacrittyConfig = import ./alacritty.nix;
in
{
	home-manager.enable = true;
	neovim = nvimConfig pkgs;
	alacritty = alacrittyConfig pkgs;
	git = gitConfig pkgs;
	zsh = zshConfig pkgs;
}