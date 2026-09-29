return {
  {
    "tomasr/molokai",
    lazy = false,
    priority = 1000,
    config = function()
      -- lazy.nvim 移行後はパスが stdpath("data")/lazy/ 以下になるため
      -- init.vim の手動パスチェックは不要
      vim.cmd("colorscheme molokai")
    end,
  },
}
