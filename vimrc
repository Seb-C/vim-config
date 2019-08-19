scriptencoding utf-8
" Plugin manager
execute pathogen#infect()
syntax on

source ~/.vim/config/sessions.vim
source ~/.vim/config/search.vim
source ~/.vim/config/tags.vim
source ~/.vim/config/window-resize.vim
source ~/.vim/config/bad-habits.vim
source ~/.vim/config/azerty.vim

if filereadable(expand('~/.vim/local_config.vim'))
    source ~/.vim/local_config.vim
endif

" Tabularize custom configuration
autocmd VimEnter * AddTabularPattern , /[^,]\+,
cnoreabbrev Align Tabularize

" Storing undo
set undodir=$HOME/.vim/undo
set undofile
set undolevels=1000
set undoreload=1000
command Undotree UndotreeShow

" vim-qf config
let g:qf_window_bottom = 0
let g:qf_loclist_window_bottom = 0

" Enabling aliases (might need to add "shopt -s expand_aliases" in top of ~/.bash_aliases file)
let $BASH_ENV = "~/.bash_aliases"

" create some aliases just for simplicity
command Ghistory Agit
cnoreabbrev Translate OpenGoogleTranslate

" Auto completion settings
filetype plugin indent on
"set omnifunc=syntaxcomplete#Complete
"set completeopt=menu,noinsert,menuone,preview
"set complete-=i

" Vim commands autocompletion
set wildmenu
set wildmode=full

" Close preview scratch window on insert leave
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Languages plugins settings
autocmd FileType scss set iskeyword+=-
autocmd FileType blade set iskeyword-=\$
let javascript_enable_domhtmlcss = 1
let g:vim_json_syntax_conceal = 0
autocmd BufRead,BufNewFile *.js set filetype=javascript.jsx
autocmd BufRead,BufNewFile *.pcss set filetype=scss
autocmd BufRead,BufNewFile *.pcss set tabstop=4

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
let NERDTreeMapQuit=''

" CtrlP plugin settings
let g:ctrlp_regexp = 1
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_max_files = 0
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_working_path_mode = 'w'
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore-dir=node_modules -g ""'
endif

" Color picker
let g:vcoolor_lowercase = 0
let g:vcoolor_disable_mappings = 1
command ColorHex :VCoolor
command ColorRgb :VCoolIns r
command ColorRgba :VCoolIns ra
command ColorHsl :VCoolIns h

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
set tabstop=4

set ruler

set backspace=indent,eol,start

set noswapfile
set nowritebackup
set mouse=""

set virtualedit=block

" Synchronizes default yank with system's clipboard
set clipboard=unnamed,unnamedplus

set timeoutlen=200

set t_Co=256
set background=dark
colorscheme gruvbox

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
set novisualbell

highlight ExtraWhitespace ctermbg=208

" Status bar
set laststatus=2
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_symbols_branch = '⇒'
let g:airline_section_b='%{fnamemodify(getcwd(), '':t'')} > %{airline#util#wrap(airline#extensions#branch#get_head(),0)}'
let g:airline_section_y='%{coc#status()}'
let g:airline_section_warning=''
set fillchars=vert:▚

autocmd Filetype scss setlocal tabstop=2 shiftwidth=2 softtabstop=2

" EditorConfig settings
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Linters
let g:syntastic_php_checkers = ['php']
let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['tslint']
let g:syntastic_javascript_eslint_exec = './node_modules/.bin/eslint'
let g:syntastic_typescript_tslint_exec = './node_modules/.bin/tslint'
let g:syntastic_auto_loc_list = 1
if filereadable('.php_cs.dist')
    if filereadable('./vendor/friendsofphp/php-cs-fixer/php-cs-fixer')
        let g:php_cs_fixer_path = './vendor/friendsofphp/php-cs-fixer/php-cs-fixer --diff'
    endif
    autocmd BufWritePost *.php call PhpCsFixerFixFile()
endif

" Also clean search results when cleaning screen
nnoremap <silent> <C-L> :noh<CR><C-L>

" Showing tabs
set listchars=tab:▸\ 
set list
