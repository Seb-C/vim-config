" Plugin manager
execute pathogen#infect()
syntax on

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

" Languages plugins settings
autocmd FileType scss set iskeyword+=-
let g:phpcomplete_parse_docblock_comments = 1
let g:phpcomplete_enhance_jump_to_definition = 0
let g:phpcomplete_relax_static_constraint = 1
let javascript_enable_domhtmlcss = 1

" Expand/insert PHP statements with \e and \u
inoremap <Leader>u <C-O>:call PhpInsertUse()<CR>
noremap <Leader>u :call PhpInsertUse()<CR>
inoremap <Leader>e <C-O>:call PhpExpandClass()<CR>
noremap <Leader>e :call PhpExpandClass()<CR>

" Tree directory listing (:E)
let g:netrw_liststyle=3

" Project plugin (configuring all nosl environments)
set rtp+=~/.vim/bundle/vim-project/
call project#rc("~/Code")
for FILE in split(system('ls -1 /data/www-local/web/nos_sites_work/', '\n'))
    Project '/data/www-local/web/nos_sites_work/'.FILE , FILE
endfor

" :Devsh command
:command BuildDevsh :!./dev.sh build

" Tags builder
:command BuildTags :!mkdir -p `echo ~/.vim/tag-files$PWD` && ~/.vim/patched-ctags/bin/ctags -R --PHP-kinds=+cf --fields=+aimS --languages=PHP,JavaScript -f `echo ~/.vim/tag-files$PWD/tags` --verbose=yes --exclude=./local/cache --exclude=./local/data --exclude=./local/applications_cloud ./novius-os ./local 2>&1 | grep -v "ignoring null tag in" | grep -v "(unknown language)"

" Defining tag files to import
let &tags = system('printf ~/.vim/tag-files$PWD/tags')

" Usual vim settings

set number
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
 
set ruler
 
set undolevels=1000
set backspace=indent,eol,start
 
 

