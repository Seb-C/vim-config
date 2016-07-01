" Plugin manager
execute pathogen#infect()
syntax on

" Tags builder (might need "apt-get install exuberant-ctags")
let buildTagsCommand = 'ctags-exuberant -R --languages=PHP,JavaScript --PHP-kinds=+cidfvj --JavaScript-kinds=+scmpv --fields=+aimnztS --verbose=yes --exclude=cache --exclude=data --exclude=logs --exclude=.git --exclude=''*.min.*'' --exclude=''*.log'' .'
command BuildTags :execute '!'.buildTagsCommand
" Refreshing tags file on save
autocmd BufWritePost *.php :echo "Rebuilding index..." | execute 'silent Dispatch! '.buildTagsCommand

" Search shortcut command
fu! SearchInProject(pattern)
  execute 'lgrep! -R '.a:pattern.' --exclude=tags --exclude=*.min.* --exclude=*.log --exclude-dir=cache --exclude-dir=logs --exclude-dir=.git --exclude-dir=data *'
  lopen
  redraw!
  set nowrap
endfunction
command -nargs=1 Search call SearchInProject(shellescape("<args>"))

" Paste from system
fu! PasteFromSystemClipBoard()
    set paste
    call feedkeys('"+p')
    set nopaste
endfunction
command Paste call PasteFromSystemClipBoard()

" Enabling aliases (might need to add "shopt -s expand_aliases" in top of ~/.bash_aliases file)
let $BASH_ENV = "~/.bash_aliases"

" Auto completion settings
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone
let g:acp_EnableAtStartup = 0
set completeopt+=preview

" HTML and view files settings
au BufRead,BufNewFile *.view.php,*.tpl set filetype=phtml
autocmd FileType html,phtml set omnifunc=htmlcomplete#CompleteTags

" Select menu item with Enter instead of <C-y>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Close preview scratch window on insert leave
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Languages plugins settings
autocmd FileType scss set iskeyword+=-
let g:phpcomplete_parse_docblock_comments = 1
let g:phpcomplete_enhance_jump_to_definition = 0
let g:phpcomplete_relax_static_constraint = 1
let javascript_enable_domhtmlcss = 1

" Tree directory listing (:E)
let g:netrw_liststyle=3

" NERDTREE
nnoremap <silent> <C-N> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
let g:NERDTreeChDirMode=2

" CtrlP plugin settings
let g:ctrlp_regexp = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_max_files = 0
let g:ctrlp_clear_cache_on_exit = 0 

" Enable fold by indent for every language
autocmd Syntax * setlocal foldmethod=indent
set foldlevel=99

" Usual vim settings

set number
set relativenumber
set linebreak
set textwidth=0
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
set nowritebackup
set mouse=a

set timeoutlen=100

set t_Co=256
set background=dark
colorscheme gruvbox

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set novisualbell

" Status bar
set laststatus=2
noremap <C-x><C-t> :TagbarToggle<CR>
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_symbols_branch = '⇒'
let g:airline_section_b='%{fnamemodify(getcwd(), '':t'')} > %{airline#util#wrap(airline#extensions#branch#get_head(),0)}'
let g:airline_section_y=''
let g:airline_section_warning=''

autocmd Filetype scss setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Expand class name or add the use tag with <C-e> and <C-u>
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php,phtml noremap <C-x><C-u> <Esc>:call IPhpInsertUse()<CR>
function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
autocmd FileType php,phtml noremap <C-x><C-e> <Esc>:call IPhpExpandClass()<CR>

" Only using php lint for now
let g:syntastic_php_checkers = ['php']
