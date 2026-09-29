return {
  {
    "iamcco/markdown-preview.nvim",
    ft    = { "markdown" },
    -- build は stdpath("data") で XDG_DATA_HOME に追従する
    build = function()
      vim.fn.jobstart({ "npm", "install" }, {
        cwd = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app",
      })
    end,
    init = function()
      vim.g.mkdp_port = ""
    end,
  },
  {
    "tpope/vim-obsession",
    lazy = false,  -- セッション復元後の自動保存 autocmd を確実に登録するため起動時ロード
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft= { "markdown" },
    opts = {
      render_modes = true,
      code = {
        width = 'block',
        min_width = 80,
        border = 'thin',
      },
      heading = {
        border = 'block',
        left_pad = 0,
        icons = {},
      },
    },
  }
}
