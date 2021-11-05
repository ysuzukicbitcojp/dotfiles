" vimrc

if &compatible
  set nocompatible
endif


" Dein TOML
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . s:dein_repo_dir
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  let g:rc_dir    = expand('~/vimfiles/rc') 
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

set noswapfile
set nobackup
set noundofile
set tabstop=4
set softtabstop=4
set expandtab
set smartindent
set hidden
set acd
set fileformats=unix,dos,mac
set fileencodings=utf-8,sjis
set iminsert=0
set imsearch=-1
set nu
set relativenumber
set nocompatible
filetype plugin indent on
syntax on

if has('win32') || has('win64')
  let g:airline_theme = 'papercolor'
  set laststatus=2
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#branch#enabled = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  let g:airline#extensions#whitespace#mixed_indent_algo = 1
  let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'y', 'z']]
  if has("win64")
  let g:airline_section_c = '%t'
  let g:airline_section_x = '%{&filetype}'
  let g:airline_section_z = '%3l:%2v %{airline#extensions#ale#get_warning()} %{airline#extensions#ale#get_error()}'
  let g:airline#extensions#ale#error_symbol = ' '
  let g:airline#extensions#ale#warning_symbol = ' '
  endif

  let g:airline#extensions#default#section_truncate_width = {}
  let g:airline#extensions#whitespace#enabled = 1

  "keymap to switch tab-line
  nmap <C-p> <Plug>AirlineSelectPrevTab
  nmap <C-n> <Plug>AirlineSelectNextTab
else
  set statusline=%F%m%h%w\ %<[ENC=%{&fenc!=''?&fenc:&enc}]\ [FMT=%{&ff}]\ [TYPE=%Y]\ %=[CODE=0x%02B]\ [POS=%l/%L(%02v)]
endif

"NERDTree
nnoremap <silent> <C-e> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 40

"garbas/vim-snipmate
"add original snippet to php
let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases['php'] = 'php,phpu'
let g:snipMate = {'snippet_version' : 1 }

"easymotion/vim-easymotion
"s{char}{char} to move to {char}{char}
map <leader>s <Plug>(easymotion-bd-f2)
nmap <leader>s <Plug>(easymotion-overwin-f2)
"Move to line
map <leader>l <Plug>(easymotion-bd-jk)
nmap <leader>l <Plug>(easymotion-overwin-line)

"Visualize tab characters, whitespace characters, and line breaks
if has("win32") || has("win64")
    :set list listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
endif


"open memo
nmap <C-h>m :e ~\memo.md<CR>
"opne vim cheatsheet
nmap <C-h>v :e ~\note\CheatSheet\vim\index.md<CR>
"opne shell cheatsheet
nmap <C-h>s :e ~\note\CheatSheet\shell\index.md<CR>

"open settings
nmap <C-s>v :e ~\.cache\nvim\init.vim<CR>

"echo buffer name in fullpatn
command! Pwd call s:print_full_path()
function! s:print_full_path()
    echo expand("%:p")
endfunction

command! Test call s:print_tabstop()
function! s:print_tabstop()
    "echo execute("set tabstop?")
    let tabstop=&tabstop
    echo tabstop
endfunction
nmap <C-h>t s:print_tabstop()


function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction

function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction

function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

"simeji/winresizer
let g:winresizer_start_key = '<C-T>'

"vimdiff
set diffopt+=vertical


"iamcco/markdown-preview
"let g:mkdp_markdown_css = expand('~/note/topics/monthly_report/css/style.css')
let g:mkdp_port = ''

augroup vimrc_loading
  autocmd!
  "suppress markdown error display
  autocmd BufnewFile,BufRead *.md hi link markdownError Normal

  "vue
  autocmd FileType vue syntax sync fromstart

  "php
  autocmd FileType php setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

  "js
  autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

  "markdown
  autocmd FileType markdown setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
  
  "toml
  autocmd BufnewFile,BufRead *.toml set filetype=yaml

  "colorscheme
  let s:molokai_plugin = s:dein_dir . '/repos/github.com/tomasr/molokai/colors/molokai.vim'
  if filereadable(s:molokai_plugin)
    colorscheme molokai
    "colorscheme slate
  else
    colorscheme slate
  endif

  "change the color of tab characters
  autocmd ColorScheme * highlight NonText guifg=#808080 ctermfg=gray

  "color scheme
  "ref : http://cohama.hateblo.jp/entry/2013/08/11/020849
  autocmd ColorScheme * highlight PreProc guifg=red guibg=grey15 ctermfg=red


augroup end
