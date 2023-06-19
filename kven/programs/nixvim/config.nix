# kven/prgrams/nixvim/config.nix
pkgs: {
  enable = true;
#   colorscheme = "ayu";
  colorschemes.tokyonight.enable = true;
  clipboard.providers.wl-copy.enable = true;
  extraPlugins = with pkgs.vimPlugins; [
    ayu-vim
    vim-nix
  ];

  options = {
    number = true;
  };

  maps = {
	normal."<C-f>" = {
		action = "<cmd>NvimTreeToggle<cr>";
	};
  };
  plugins = {
    copilot.enable = true;
    nvim-tree.enable = true;
    lsp = {
      enable = true;
      servers = {
        rust-analyzer.enable = true;
        # nixd.enable = true;
      };
    };
    # barbar.enable = true;
    # gitgutter.enable = true;
    # indent-blankline.enable = true;
  };

  extraConfigLua = ''
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.api.nvim_set_keymap("i", "<C-e>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
	vim.cmd(":highlight SignColumn guibg=NONE")
	vim.cmd(":hi Normal guibg=NONE ctermbg=NONE")
	vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]
  '';
}
