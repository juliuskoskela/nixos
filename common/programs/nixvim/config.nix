# common/programs/nixvim/config.nix
pkgs: {
  enable = true;

  colorschemes = {
    tokyonight.enable = true;
  };

  clipboard = {
    providers.wl-copy.enable = true;
    register = "unnamedplus";
  };

  extraPlugins = with pkgs.vimPlugins; [
    # Nix expressions in Neovim.
    vim-nix

    # Git command under G(it) menu
    vim-fugitive

    # Rust file detection, syntax highlighting, formatting, Syntastic integration, and more.
    rust-vim
    # nvim-treesitter.withAllGrammars
    # Corrects ripgrep error with telescope
    telescope-live-grep-args-nvim

    # Bookmarks: new bookmark <mm>, next bookmark <mn>, ...
    vim-bookmarks

    # TODO: Couldn't get these to work, but interesting...
    # noice-nvim
    # nvim-notify
    # leap-nvim
  ];

  options = {
    number = true;
  };

  # Key mappings
  maps = {
    # Close buffer
    normal."<space>q".action = "<cmd>q<cr>";

    # Close buffer (force)
    normal."<space>Q".action = "<cmd>q!<cr>";

    # Save buffer
    normal."<space>w".action = "<cmd>w<cr>";

    # Toggle file explorer
    normal."<space>e".action = "<cmd>NvimTreeToggle<cr>";

    # Toggle file finder
    normal."<space>f".action = "<cmd>Telescope find_files<CR>";

    # Toggle buffer finder
    normal."<space>b".action = "<cmd>Telescope buffers<CR>";

    # Toggle meta finder
    normal."<space>p".action = "<cmd>Telescope<CR>";

    # Toggle Git view
    normal."<space>g".action = "<cmd>Neogit<CR>";

    # Toggle floating terminal
    normal."<space>t".action = "<cmd>FloatermToggle<CR>";

    # Git diff
    normal."<space>d".action = "<cmd>G diff<CR>";
  };

  plugins = {
    copilot.enable = true; # Github CoPilot
    nvim-tree.enable = true; # File browser
    gitgutter.enable = true; # Git information in editor gutter
    comment-nvim.enable = true; # Comment with `gc` `gcc` etc.
    lualine.enable = true; # Status line
    telescope.enable = true; # Fuzzy finder
    nvim-cmp.enable = true; # Autocompletion
    rust-tools.enable = true; # Rust tools
    neogit.enable = true; # Git integration
    indent-blankline.enable = true; # Indentation lines

    # Dashboard
    alpha = {
      enable = true;
      layout = [
        {
          type = "padding";
          val = 2;
        }
        {
          opts = {
            hl = "Type";
            position = "center";
          };
          type = "text";
          val = [
            "  ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗  "
            "  ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║  "
            "  ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║  "
            "  ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║  "
            "  ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║  "
            "  ╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝  "
          ];
        }
        {
          type = "padding";
          val = 2;
        }
        {
          type = "group";
          val = [
            {
              command = "<CMD>ene <CR>";
              desc = "  New file";
              shortcut = "e";
            }
            {
              command = ":qa<CR>";
              desc = "  Quit Neovim";
              shortcut = "SPC q";
            }
          ];
        }
        {
          type = "padding";
          val = 2;
        }
        {
          opts = {
            hl = "Keyword";
            position = "center";
          };
          type = "text";
          val = "Inspiring quote here.";
        }
      ];
    };

    # barbar = {
    #   enable = true;
    #   autoHide = true;
    # };
    # dashboard.enable = true; # Dashboard !TODO coonfigure, now blank
    # trouble.enable = true; # Error list
    # coq-nvim.enable = true; # Autocompletion

    # Floating terminal
    floaterm = {
      enable = true;
      shell = "zsh";
    };

    # Language servers
    # !TODO Make it an input
    lsp = {
      enable = true;
      servers = {
        # Rust
        rust-analyzer.enable = true;

        # !TODO Find a better Nix linter, this was broken!
        rnix-lsp.enable = true;

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

      keymaps.lspBuf = {
        K = "hover";
        gD = "references";
        gd = "definition";
        gi = "implementation";
        gt = "type_definition";
      };
    };
  };

  extraConfigLua = ''
    -- Set clipboard to unnamedplus for wl-copy
    vim.g.clipboard=unnamedplus

    -- Remap copilot to `Control e` (mapping with Nixvim the command printed garbage at the end of the output)
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.api.nvim_set_keymap("i", "<C-e>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

    -- Remove backgrounds that don't stretch to the terminal window
    vim.cmd(":highlight SignColumn guibg=NONE")
    vim.cmd(":hi Normal guibg=NONE ctermbg=NONE")
    vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]
  '';
}
