{ pkgs, ... }:
let
  shell-aliases = import ./shell-aliases.nix;
in
{
  nixvim = {
    enable = true;
    colorscheme = "ayu";
    extraPlugins = with pkgs.vimPlugins; [
      ayu-vim
      vim-nix
    ];
    plugins = {
      copilot.enable = true;
      lsp.enable = true;
    };
  };
  alacritty = import ../../programs/terminal/alacritty.nix;
  zsh = import ../../programs/shell/zsh.nix { inherit shell-aliases; };
  git = {
    enable = true;
    userName = "Julius Koskela";
    userEmail = "me@juliuskoskela.dev";

    extraConfig = {
      commit.gpgsign = true;
      user.signingkey = "8539EF4CE6367B81";
    };
  };

  helix = {
    enable = true;
    settings.theme = "onedark";
  };
}
