return {
  {
    "easymotion/vim-easymotion",
    keys = {
      { "<leader>s", "<Plug>(easymotion-bd-f2)",      mode = "x" },
      { "<leader>s", "<Plug>(easymotion-overwin-f2)", mode = "n" },
      { "<leader>l", "<Plug>(easymotion-bd-jk)",      mode = "x" },
      { "<leader>l", "<Plug>(easymotion-overwin-line)", mode = "n" },
    },
  },
  { "tpope/vim-surround" },
  { "tpope/vim-commentary" },
  { "simeji/winresizer" },
  { "leafgarland/typescript-vim", ft = { "typescript", "typescriptreact" } },
  { "guns/xterm-color-table.vim", cmd = "XtermColorTable" },
  { "dhruvasagar/vim-table-mode", ft = "markdown" },
  { "dkarter/bullets.vim", ft = "markdown" },
}
