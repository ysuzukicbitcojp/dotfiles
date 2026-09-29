local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ファイルタイプ別インデント・シンタックス設定
local vimrc = augroup("vimrc_loading", { clear = true })

autocmd({ "BufNewFile", "BufRead" }, {
  group = vimrc, pattern = "*.md",
  command = "hi link markdownError Normal",
})
autocmd("FileType", {
  group = vimrc, pattern = "vue",
  command = "syntax sync fromstart",
})
autocmd("FileType", {
  group = vimrc, pattern = "php",
  command = "setlocal tabstop=4 softtabstop=4 shiftwidth=4 expandtab",
})
autocmd("FileType", {
  group = vimrc, pattern = "javascript",
  command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab",
})
autocmd("FileType", {
  group = vimrc, pattern = "markdown",
  command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab",
})
autocmd({ "BufNewFile", "BufRead" }, {
  group = vimrc, pattern = "*.toml",
  command = "set filetype=yaml",
})

-- カラースキーム変更後の色上書き
autocmd("ColorScheme", {
  group = vimrc,
  callback = function()
    vim.cmd("highlight NonText guifg=#808080 ctermfg=gray")
    vim.cmd("highlight PreProc guifg=red guibg=grey15 ctermfg=red")
  end,
})

-- diff ハイライト
vim.cmd([[
  hi DiffAdd    cterm=bold ctermfg=46  ctermbg=236
  hi DiffChange cterm=bold ctermfg=220 ctermbg=236
  hi DiffDelete cterm=bold ctermfg=160 ctermbg=236
  hi DiffText   cterm=bold ctermfg=33  ctermbg=236
]])

-- diff モード専用キーマップ
local diff_mode = augroup("DIFF_MODE", { clear = true })
autocmd("BufEnter", {
  group = diff_mode,
  callback = function()
    if vim.opt.diff:get() then
      vim.keymap.set("n", "dp", ":diffput<CR>", { buffer = true })
      vim.keymap.set("n", "dg", ":diffget<CR>", { buffer = true })
      vim.keymap.set("n", "<M-n>", "]c", { buffer = true })
      vim.keymap.set("n", "<M-p>", "[c", { buffer = true })
    end
  end,
})
autocmd("BufLeave", {
  group = diff_mode,
  callback = function()
    if vim.opt.diff:get() then
      pcall(vim.keymap.del, "n", "dp", { buffer = true })
      pcall(vim.keymap.del, "n", "dg", { buffer = true })
      pcall(vim.keymap.del, "n", "<M-n>", { buffer = true })
      pcall(vim.keymap.del, "n", "<M-p>", { buffer = true })
    end
  end,
})

-- WSL zenhan: ノーマルモード移行時にIMEをOFF
-- zenhan.exe のパスは環境変数 ZENHAN_PATH で指定する（未設定なら無効）
-- 例: export ZENHAN_PATH="/mnt/c/Users/<username>/work/tools/zenhan/zenhan.exe"
local zenhan_exe = os.getenv("ZENHAN_PATH")
if zenhan_exe and vim.uv.fs_stat(zenhan_exe) then
  local zenhan_cmd = zenhan_exe .. " 0"
  local wsl_zenhan = augroup("WSLZenhan", { clear = true })
  autocmd("CmdlineLeave", {
    group = wsl_zenhan,
    callback = function() vim.fn.system(zenhan_cmd) end,
  })
  autocmd("InsertLeave", {
    group = wsl_zenhan,
    callback = function() vim.fn.system(zenhan_cmd) end,
  })
end

-- quickfix: dd でエントリを削除
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "dd", function()
      local idx = vim.fn.line(".") - 1
      local qfall = vim.fn.getqflist()
      table.remove(qfall, idx + 1)
      vim.fn.setqflist(qfall, "r")
      vim.cmd(tostring(idx + 1) .. "cfirst")
      vim.cmd("copen")
    end, { buffer = true })
  end,
})
