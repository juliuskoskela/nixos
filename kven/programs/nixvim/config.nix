# kven/prgrams/nixvim/config.nix
pkgs: {
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
}
