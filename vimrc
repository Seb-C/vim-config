" Plugin manager
execute pathogen#infect()
syntax on

" Tags builder (might need "apt-get install exuberant-ctags")
let buildTagsCommand = 'ctags-exuberant -R --PHP-kinds=+cidfvj --fields=+aimnztS --languages=PHP --regex-PHP=''/^\s*namespace\s+([^;]*)/\\\\\1/c/'' --regex-PHP=''/^\s*namespace\s+([^;]*)/\1/c/'' --regex-PHP=''/class\s+([^ ]*)/\\\\\1/c/'' --verbose=yes --exclude=./local/cache --exclude=./local/data --exclude=*.min.* ./novius-os ./local'
:command BuildTags :execute '!'.buildTagsCommand
" Refreshing tags file on save
autocmd BufWritePost *.php :echo "Rebuilding index..." | execute 'Dispatch! '.buildTagsCommand

" Search shortcut command
fu! NoviusSearch(pattern)
  execute 'grep! -r '.a:pattern.' --exclude local/cache/** --exclude tags --exclude *.min.* *'
  copen
  redraw!
endfunction
command -nargs=1 Search call NoviusSearch(shellescape("<args>"))

" Enabling aliases (might need to add "shopt -s expand_aliases" in top of ~/.bash_aliases file)
let $BASH_ENV = "~/.bash_aliases"

" Auto completion settings
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
:set completeopt=longest,menuone
let g:acp_EnableAtStartup = 0
:set completeopt+=preview

" Select menu item with Enter instead of <C-y>
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Close preview scratch window on insert leave
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Open autocompletion with <tab>
autocmd FileType * 
      \if &omnifunc != '' |
      \call SuperTabChain(&omnifunc, "<c-p>") |
      \call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
      \endif

" Adds namespace separator for php autocompletion
autocmd Filetype php setlocal iskeyword+=\\

" Languages plugins settings
autocmd FileType scss set iskeyword+=-
let g:phpcomplete_parse_docblock_comments = 1
let g:phpcomplete_enhance_jump_to_definition = 0
let g:phpcomplete_relax_static_constraint = 1
let javascript_enable_domhtmlcss = 1

" Tree directory listing (:E)
let g:netrw_liststyle=3

" Project plugin (configuring all nosl environments)
set rtp+=~/.vim/bundle/vim-project/
call project#rc("~/Code")
let g:project_use_nerdtree = 1
for FILE in split(system('ls -1 /data/www-local/web/nos_sites_work/', '\n'))
    Project '/data/www-local/web/nos_sites_work/'.FILE , FILE
endfor

" :Devsh command
:let $TERMINAL = 'xterm'
:command BuildDevsh :!./dev.sh build
autocmd BufWritePost *.scss,*.js,*.css :Start ./dev.sh build

" Enable fold by indent for every language
autocmd Syntax * setlocal foldmethod=indent
autocmd Syntax * normal zR

" Usual vim settings

set number
set relativenumber
set linebreak
set textwidth=100
set showmatch
set visualbell
 
set hlsearch
set smartcase
set ignorecase
set incsearch
 
set autoindent
set expandtab
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
set shiftwidth=4
 
set ruler
 
set undolevels=1000
set backspace=indent,eol,start

set noswapfile
set mouse=a

autocmd Filetype scss setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Expand class name or add the use tag with <C-e> and <C-u>
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <C-u> <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <C-u> :call PhpInsertUse()<CR>
function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <C-e> <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <C-e> :call PhpExpandClass()<CR>
