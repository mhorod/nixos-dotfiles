let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    ref = "nixos-24.11";
  });
in let
  alejandra =
    (import (builtins.fetchTarball {
      url = "https://github.com/kamadorueda/alejandra/tarball/3.1.0";
      sha256 = "102pgnbsbvhpqy5brzs45lrignxbmbkp68ll7966prlr6myr4i43";
    }) {})
    .outPath;
in {
  environment.systemPackages = [alejandra];

  imports = [nixvim.nixosModules.nixvim];
  programs.nixvim = {
    enable = true;

    colorschemes.gruvbox.enable = true;

    opts = {
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;
      smartindent = true;
      termguicolors = true;
      hlsearch = false;
      incsearch = true;
      hidden = true;
      number = true;
      cursorline = true;
      colorcolumn = "80";
      clipboard = "unnamedplus";
    };

    highlightOverride = {
      Normal.bg = "NONE";
    };

    plugins = {
      web-devicons.enable = true;
      neo-tree.enable = true;
      rustaceanvim.enable = true;
      coq-nvim = {
        enable = true;
        settings.auto_start = true;
      };

      treesitter = {
        enable = true;
        settings.highlight.enable = true;
      };

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            nix = ["alejandra"];
            rust = ["rustfmt"];
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<C-S-i>";
        action = "<cmd>lua require('conform').format()<CR>";
        options = {
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "<C-n>";
        action = "<cmd>Neotree toggle left<CR>";
      }
    ];
  };
}
