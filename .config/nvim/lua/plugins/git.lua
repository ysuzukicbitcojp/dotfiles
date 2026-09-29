return {
  {
    "airblade/vim-gitgutter",
    event = "BufReadPre",
    init = function()
      vim.opt.signcolumn = "yes"
      vim.opt.updatetime = 100
    end,
    keys = {
      { "]h", "<Plug>(GitGutterNextHunk)" },
      { "[h", "<Plug>(GitGutterPrevHunk)" },
    },
  },
  {
    "tpope/vim-fugitive",
    lazy=false,
    cmd = { "Git", "Gstatus", "Gblame", "Gdiff", "Glog" },
  },
}
