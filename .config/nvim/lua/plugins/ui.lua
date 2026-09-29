return {
  { "ryanoasis/vim-devicons" },
  -- themes を airline より先に runtimepath へ追加するため独立エントリで明示ロード
  { "vim-airline/vim-airline-themes", lazy = false },
  {
    "vim-airline/vim-airline",
    lazy = false,
    dependencies = { "vim-airline/vim-airline-themes" },
    init = function()
      vim.g.airline_theme                                        = "molokai"
      vim.g.airline_powerline_fonts                              = 1
      vim.g["airline#extensions#branch#enabled"]                 = 1
      vim.g["airline#extensions#whitespace#mixed_indent_algo"]   = 1
      vim.g["airline#extensions#default#layout"]                 = { { "a", "b", "c" }, { "x", "y", "z" } }
      vim.g.airline_section_c                                    = "%t"
      vim.g.airline_section_x                                    = "%{&filetype}"
      -- Lua の {} は VimScript では空配列になるため vim.empty_dict() を使う
      vim.g["airline#extensions#default#section_truncate_width"] = vim.empty_dict()
      vim.g["airline#extensions#whitespace#enabled"]             = 1
      vim.opt.laststatus                                         = 2
    end,
  },
}
