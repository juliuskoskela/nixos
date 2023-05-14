pkgs:
	let userAliases = import ./shell-aliases.nix; in
{
	enable = true;
	shellAliases = userAliases pkgs;

	oh-my-zsh = {
		enable = true;
		plugins = [ "git" ];
		theme = "robbyrussell";
  	};
}