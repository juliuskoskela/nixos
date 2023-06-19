# kven/prgrams/nixvim/config.nix
pkgs: {
  enable = true;

  colorschemes.tokyonight.enable = true;

  clipboard = {
	providers.wl-copy.enable = true;
    register = "unnamedplus";
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-nix         # Nix linting
	vim-fugitive	# Git commands "G: add ."
	rust-vim        # Rust file detection, syntax highlighting, formatting, Syntastic integration, and more.
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
		rnix-lsp.enable = true;
		lua-ls.enable = true;
		ltex.enable = true;
		clangd.enable = true;
		pylsp.enable = true;
		hls.enable = true;
		html.enable = true;
		bashls.enable = true;
      };
    };
  };

  extraConfigLua = ''
    vim.g.clipboard=unnamedplus
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.api.nvim_set_keymap("i", "<C-e>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    vim.cmd(":highlight SignColumn guibg=NONE")
    vim.cmd(":hi Normal guibg=NONE ctermbg=NONE")
    vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]
  '';
}
