require "paq" {
    "savq/paq-nvim";                  -- Let Paq manage itself
-- Aparência
    "dracula/vim";
    "bling/vim-airline";
    "lukas-reineke/indent-blankline.nvim";
    "mhinz/vim-startify";
    "ryanoasis/vim-devicons";
-- Utilitários
    "nvim-lua/popup.nvim";
    "nvim-lua/plenary.nvim";
    "nvim-telescope/telescope.nvim";
    {"nvim-telescope/telescope-fzf-native.nvim", build = 'make'};
    "tpope/vim-commentary";
    "jiangmiao/auto-pairs";
    "tpope/vim-surround";
    "voldikss/vim-floaterm";
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"};
    "nvim-treesitter/nvim-treesitter-textobjects";
    {"ms-jpq/coq_nvim", branch = "coq"};
    "ms-jpq/coq.thirdparty";
    "neovim/nvim-lspconfig";
    "mfussenegger/nvim-dap";
    "jbyuki/one-small-step-for-vimkind"; -- NvimLua DAP
    "theHamsta/nvim-dap-virtual-text";
-- Latex
    {"lervag/vimtex", opt=true};
-- Git
    "airblade/vim-gitgutter";
}
