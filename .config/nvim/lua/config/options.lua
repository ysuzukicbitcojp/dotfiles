vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.hidden = true
vim.opt.fileformats = { "unix", "dos", "mac" }
vim.opt.fileencodings = { "utf-8", "sjis" }
vim.opt.iminsert = 0
vim.opt.imsearch = -1
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.cmdheight = 2
vim.opt.list = true
vim.opt.listchars = { tab = "»-", trail = "-", eol = "↲", extends = "»", precedes = "«", nbsp = "%" }
vim.opt.diffopt:append("vertical")

-- grep: ripgrepが使える場合は優先
if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep --hidden"
  vim.opt.grepformat = "%f:%l:%c:%m"
end

-- python3: pyenvのshinmsがあればそちらを優先、なければPATHから解決
local pyenv_python = vim.fn.expand("~/.pyenv/shims/python3")
if vim.uv.fs_stat(pyenv_python) then
  vim.g.python3_host_prog = pyenv_python
else
  vim.g.python3_host_prog = vim.fn.exepath("python3")
end
