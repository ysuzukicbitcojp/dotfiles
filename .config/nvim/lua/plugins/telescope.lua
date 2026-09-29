return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "v0.1.9",  -- v0.2.0+ は nvim 0.10.4 以上が必要。nvim を更新したらタグを外す
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<Leader>p", "<cmd>Telescope git_files<CR>",   silent = true },
      { "<Leader>P", "<cmd>Telescope find_files<CR>",  silent = true },
      { "<Leader>g", "<cmd>Telescope live_grep<CR>",   silent = true },
      { "<Leader>b", "<cmd>Telescope buffers<CR>",     silent = true },
      { "<Leader>m", "<cmd>Telescope marks<CR>",       silent = true },
      { "<Leader>c", "<cmd>Telescope colorscheme<CR>", silent = true },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              -- 選択後にインサートモードを抜ける
              ["<CR>"] = function(bufnr)
                require("telescope.actions").select_default(bufnr)
                vim.cmd("stopinsert")
              end,
            },
          },
        },
      })
      vim.cmd("highlight TelescopeSelection guibg=#2e2e2e guifg=#ffffff")
    end,
  },
}
