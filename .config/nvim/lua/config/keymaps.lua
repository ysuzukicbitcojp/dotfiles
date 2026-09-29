local map = vim.keymap.set

-- ハイライト解除
map("n", "<leader>c", ":noh<CR>", { silent = true })
map("n", "<C-h>", ":noh<CR>", { silent = true })

-- タブ操作
map("n", "tn", ":tabnext<CR>")
map("n", "tp", ":tabprevious<CR>")

-- 保存・終了
map("n", "<C-x>", ":qa<CR>")
map("n", "<C-s>", ":w<CR>")

-- ctags ジャンプ（縦分割 / 横分割）
map("n", "tv", ":vsp<CR>:exe('tjump '.expand('<cword>'))<CR>")
map("n", "th", ":split<CR>:exe('tjump '.expand('<cword>'))<CR>")

-- ビジュアル選択範囲の文字列置換（[We]/[they]形式）
vim.cmd([[
  vnoremap <leader>r :<C-U>
    \ let @a = input('置き換える文字列A: ') \|
    \ let @b = input('置き換える文字列B: ') \|
    \ execute "'<,'>s/" . @a . "/[We]/g" \|
    \ execute "'<,'>s/" . @b . "/[they]/g"<CR>
]])

-- 丸数字 ①〜⑨ と 1.〜9. を相互変換するユーティリティ
-- 使い方: :lua CvtMarusujiToSuji() / :lua CvtSujiToMarusuji()
local maru_to_suji = { ["①"]="1.", ["②"]="2.", ["③"]="3.", ["④"]="4.", ["⑤"]="5.",
                       ["⑥"]="6.", ["⑦"]="7.", ["⑧"]="8.", ["⑨"]="9." }
local suji_to_maru = {}
for k, v in pairs(maru_to_suji) do suji_to_maru[v] = k end

function CvtMarusujiToSuji()
  local line = vim.fn.getline(".")
  for sym, num in pairs(maru_to_suji) do line = line:gsub(sym, num) end
  vim.fn.setline(".", line)
end

function CvtSujiToMarusuji()
  local line = vim.fn.getline(".")
  for num, sym in pairs(suji_to_maru) do line = line:gsub(vim.pesc(num), sym) end
  vim.fn.setline(".", line)
end
