execute pathogen#infect()
syntax on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

:set completeopt=longest,menuone
let g:acp_EnableAtStartup = 0
:set completeopt+=preview
autocmd FileType scss set iskeyword+=-

" Select menu item with Enter instead of <C-y>
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Close preview scratch window on insert leave
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

let g:phpcomplete_parse_docblock_comments = 1
let g:phpcomplete_enhance_jump_to_definition = 0
let javascript_enable_domhtmlcss = 1

autocmd FileType * 
      \if &omnifunc != '' |
      \call SuperTabChain(&omnifunc, "<c-p>") |
      \call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
      \endif

" Enabling aliases (might need to add "shopt -s expand_aliases" in top of ~/.bash_aliases file)
let $BASH_ENV = "~/.bash_aliases"

" Tree directory listing (:E)
let g:netrw_liststyle=3

" Project plugin (configuring all nosl environments)
set rtp+=~/.vim/bundle/vim-project/
call project#rc("~/Code")
for FILE in split(system('ls -1 /data/www-local/web/nos_sites_work/', '\n'))
    Project '/data/www-local/web/nos_sites_work/'.FILE , FILE
endfor

" :devsh command
:command Build :!./dev.sh build

set number
set linebreak
set showbreak=+++
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
 
set ruler
 
set undolevels=1000
set backspace=indent,eol,start
 
 

