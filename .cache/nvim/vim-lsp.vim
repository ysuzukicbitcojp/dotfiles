" <lsp-settings>
" "    <200-lsp.vim>
" "      https://mattn.kaoriya.net/software/vim/20191231213507.htm
" "if empty(globpath(&rtp, 'autoload/lsp.vim'))
" "  finish
" "endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> sd <plug>(lsp-hover)
  nmap <buffer> <f2> <plug>(lsp-rename)
  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file =
xpand('~/lsp.log')

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 1
"    </200-lsp.vim>
"    <disable Auto popup>
"      https://github.com/prabirshrestha/asyncomplete.vim#auto-popup
let g:asyncomplete_auto_popup = 0

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"    </disable Auto popup>
" </lsp-settings>



set list listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%


let g:lsp_settings = {
      \   'intelephense': {
      \     'workspace_config': {
      \       'intelephense': {
      \         'stubs': [
      \                  'apache',
      \                  'bcmath',
      \                  'bz2',
      \                  'calendar',
      \                  'com_dotnet',
      \                  'Core',
      \                  'ctype',
      \                  'curl',
      \                  'date',
      \                  'dba',
      \                  'dom',
      \                  'enchant',
      \                  'exif',
      \                  'FFI',
      \                  'fileinfo',
      \                  'filter',
      \                  'fpm',
      \                  'ftp',
      \                  'gd',
      \                  'gettext',
      \                  'gmp',
      \                  'hash',
      \                  'iconv',
      \                  'imap',
      \                  'intl',
      \                  'json',
      \                  'ldap',
      \                  'libxml',
      \                  'mbstring',
      \                  'meta',
      \                  'mysqli',
      \                  'oci8',
      \                  'odbc',
      \                  'openssl',
      \                  'pcntl',
      \                  'pcre',
      \                  'PDO',
      \                  'pdo_ibm',
      \                  'pdo_mysql',
      \                  'pdo_pgsql',
      \                  'pdo_sqlite',
      \                  'pgsql',
      \                  'Phar',
      \                  'posix',
      \                  'pspell',
      \                  'readline',
      \                  'Reflection',
      \                  'session',
      \                  'shmop',
      \                  'SimpleXML',
      \                  'snmp',
      \                  'soap',
      \                  'sockets',
      \                  'sodium',
      \                  'SPL',
      \                  'sqlite3',
      \                  'standard',
      \                  'superglobals',
      \                  'sysvmsg',
      \                  'sysvsem',
      \                  'sysvshm',
      \                  'tidy',
      \                  'tokenizer',
      \                  'xml',
      \                  'xmlreader',
      \                  'xmlrpc',
      \                  'xmlwriter',
      \                  'xsl',
      \                  'Zend OPcache',
      \                  'zip',
      \                  'zlib',
      \                  'wordpress'
      \         ]
      \       }
      \     }
      \   }
      \ }

"
