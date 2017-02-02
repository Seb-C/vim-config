" Plugin manager
execute pathogen#infect()
syntax on

" Tags builder (might need "apt-get install exuberant-ctags")
let buildTagsCommand = 'ctags-exuberant -R --languages=PHP,JavaScript --PHP-kinds=+cidfvj --JavaScript-kinds=+scmpv --fields=+aimnztS --verbose=yes --exclude=cache --exclude=data --exclude=logs --exclude=.git --exclude=dist --exclude=''*.min.*'' --exclude=''*.log'' --exclude=node_modules .'
command BuildTags :execute '!'.buildTagsCommand
" Refreshing tags file on save
autocmd BufWritePost *.php :echo "Rebuilding index..." | execute 'silent Dispatch! '.buildTagsCommand

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
autocmd BufWinEnter quickfix nmap s h
autocmd BufWinEnter quickfix nmap S H

" Enabling aliases (might need to add "shopt -s expand_aliases" in top of ~/.bash_aliases file)
let $BASH_ENV = "~/.bash_aliases"

" create some aliases just for simplicity
command Ghistory Agit
command Undotree UndotreeShow

" Auto completion settings
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set completeopt=menuone,preview
let g:acp_EnableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1

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
let g:vim_json_syntax_conceal = 0

" Tree directory listing (:E)
let g:netrw_liststyle=3
let g:netrw_banner=0

" NERDTree
nnoremap <silent> <C-N> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
let g:NERDTreeChDirMode=2
let NERDTreeShowHidden=1
let NERDTreeMapOpenSplit='s'
let NERDTreeMapOpenVSplit='v'

" CtrlP plugin settings
let g:ctrlp_regexp = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_max_files = 0
let g:ctrlp_clear_cache_on_exit = 1 
let g:ctrlp_working_path_mode = 'w'
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore-dir=node_modules -g ""'
endif

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

set timeoutlen=200

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
let g:syntastic_auto_loc_list = 1

" Also clean search results when cleaning screen
nnoremap <silent> <C-L> :noh<CR><C-L>

" Unmapping some keys to change my bad habits
noremap <Insert> <Nop>
inoremap <Insert> <Nop>
noremap <Del> <Nop>
inoremap <Del> <Nop>
noremap <PageUp> <Nop>
inoremap <PageUp> <Nop>
noremap <PageDown> <Nop>
inoremap <PageDown> <Nop>
noremap <Home> <Nop>
inoremap <Home> <Nop>
noremap <End> <Nop>
inoremap <End> <Nop>
noremap <Up> <Nop>
inoremap <Up> <Nop>
noremap <Down> <Nop>
inoremap <Down> <Nop>
noremap <Left> <Nop>
inoremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Right> <Nop>

" Some specific keys to make vim easier with an AZERTY keyboard

" Make digits usable without maintaining the shift key
noremap & 1
noremap é 2
noremap " 3
noremap ' 4
noremap ( 5
noremap - 6
noremap è 7
noremap _ 8
noremap ç 9
noremap à 0

" Non digits may be used with shift instead
noremap 1 &
noremap 2 é
noremap 3 "
noremap 4 '
noremap 5 (
noremap 6 -
noremap 7 è
noremap 8 _
noremap 9 ç
noremap 0 à

" M is not in the middle on an AZERTY keyboard, so we use K
" instead (default = Help, but who needs help anyway ;D )
"noremap K M

" To go on a mark, use M, to save a mark, use m
"noremap M '

" Use ù to use a macro, since @ is not easy to reach on an AZERTY
"noremap ù @









