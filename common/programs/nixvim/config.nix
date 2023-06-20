# common/prgrams/nixvim/config.nix
pkgs: {
  enable = true;

  colorschemes.tokyonight.enable = true;

  clipboard = {
    providers.wl-copy.enable = true;
    register = "unnamedplus";
  };

  extraPlugins = with pkgs.vimPlugins; [
    vim-nix # Nix expressions in Neovim.
    vim-fugitive # Git commands "G: add ."
    rust-vim # Rust file detection, syntax highlighting, formatting, Syntastic integration, and more.
  ];

  options = {
    number = true;
  };

  maps = {
    # Toggle file explorer
    normal."<C-f>" = {
      action = "<cmd>NvimTreeToggle<cr>";
    };
  };

  plugins = {
    copilot.enable = true; # Github CoPilot
    nvim-tree.enable = true; # File browser
    gitgutter.enable = true; # Git information in editor gutter
    barbar.enable = true; # Tab bars at the top
    comment-nvim.enable = true; # Comment with `gc` `gcc` etc.
    dashboard.enable = true; # Dashboard !TODO coonfigure, now blank

    # Language servers
    lsp = {
      enable = true;
      servers = {

        # Rust
        rust-analyzer.enable = true;

        # rnix-lsp.enable = true; !TODO Find a better Nix linter, this was broken!

        # Lua
        lua-ls.enable = true;

        # LaTex
        ltex.enable = true;

        # C, C++ etc.
        clangd.enable = true;

        # Python
        pylsp.enable = true;

        # Haskell
        hls.enable = true;

        # Html
        html.enable = true;

        # Bash
        bashls.enable = true;
      };
    };
  };

  extraConfigLua = ''
    -- Set clipboard to unnamedplus for wl-copy
    vim.g.clipboard=unnamedplus

    -- Remap copilot to C-e (mapping with Nixvim the command printed garbage at the end of the output)
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.api.nvim_set_keymap("i", "<C-e>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

    -- Remove backgrounds that don't stretch to the terminal window
    vim.cmd(":highlight SignColumn guibg=NONE")
    vim.cmd(":hi Normal guibg=NONE ctermbg=NONE")
    vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]
  '';
}
