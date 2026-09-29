return {
  {
    "SirVer/ultisnips",
    dependencies = { "honza/vim-snippets" },
    -- UltiSnips の変数は init で設定する（plugin読み込み前に評価される必要があるため）
    init = function()
      -- スニペットディレクトリは stdpath("config") で XDG_CONFIG_HOME に追従する
      vim.g.UltiSnipsSnippetDirectories = { vim.fn.stdpath("config") .. "/UltiSnips" }
      vim.g.UltiSnipsExpandTrigger      = "<Tab>"
      vim.g.UltiSnipsJumpForwardTrigger = "<C-j>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<C-k>"
    end,
  },
}
