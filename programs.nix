pkgs:
let
	zshConfig = import ./configs/zsh.nix;
	gitConfig = import ./configs/git.nix;
	alacrittyConfig = import ./configs/alacritty.nix;
in
{
	modules = [ nvim ];
	home-manager.enable = true;
	neovim.enable = true;
	alacritty = alacrittyConfig pkgs;
	git = gitConfig pkgs;
	zsh = zshConfig pkgs;

	helix = {
		enable = true;
		settings.theme = "onedark";
	};
}