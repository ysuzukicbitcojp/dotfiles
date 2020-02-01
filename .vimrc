" vimrc
set noundofile
set noswapfile
set nobackup
set tabstop=4
set softtabstop=4
set shiftwidth=4
set ambiwidth=double
set hidden
set fileformats=unix,dos,mac
set fileencodings=utf-8,sjis
set iminsert=0
set imsearch=-1
syntax on
set nocompatible
filetype off

" dein settings BEGIN -->
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/dein/')
  call dein#begin('~/.vim/dein/')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('MattesGroeger/vim-bookmarks')
  call dein#add('beanworks/vim-phpfmt')
  call dein#add('easymotion/vim-easymotion')
  call dein#add('tomasr/molokai')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" dein settings END  <---
" Powerline系フォントを利用する
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline_theme = 'papercolor'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '≫'
let g:airline_left_sep = '>'
let g:airline_right_sep = '≪'
let g:airline_right_sep = '<'
let g:airline_symbols.crypt = '鍵'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'T'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = '|'
let g:airline_left_alt_sep = '|'
let g:airline_right_sep = '|'
let g:airline_right_alt_sep = '|'
let g:airline_symbols.branch = '|'
let g:airline_symbols.readonly = '読専'
let g:airline_symbols.linenr = '|'

colo molokai


"
" vim-phpfmt
" A standard type: PEAR, PHPCS, PSR1, PSR2, Squiz and Zend
"let g:phpfmt_standard = 'PSR2'
"let g:phpfmt_autosave = 1
