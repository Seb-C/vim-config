scriptencoding utf-8
" Plugin manager
execute pathogen#infect()
filetype plugin indent on
syntax on

source ~/.vim/config/sessions.vim
source ~/.vim/config/bad-habits.vim

let mapleader = "\\"

" Tabularize custom configuration
autocmd VimEnter * AddTabularPattern , /[^,]\+,
cnoreabbrev Align Tabularize

" Storing undo
set undodir=$HOME/.vim/undo
set undofile
set undolevels=1000
set undoreload=1000
command Undotree UndotreeShow

" Tagbar
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
noremap <C-x><C-t> :TagbarToggle<CR>

" vim-qf config
let g:qf_window_bottom = 0
let g:qf_loclist_window_bottom = 0

" Enabling aliases (might need to add "shopt -s expand_aliases" in top of ~/.bash_aliases file)
let $BASH_ENV = "~/.bash_aliases"

" create some aliases just for simplicity
command Ghistory Agit

" Auto completion settings
set omnifunc=syntaxcomplete#Complete
set completeopt=menu,noinsert,menuone,preview
set complete-=i
let g:acp_EnableAtStartup = 1
let g:acp_completeoptPreview = 1
let g:acp_completeOption = &complete

" Keybindings for coc.nvim
nmap <Leader>t <Plug>(coc-type-definition)
nmap <Leader>d <Plug>(coc-type-definition)
nmap <Leader>i <Plug>(coc-implementation)
nmap <Leader>c <Plug>(coc-references)
nmap <Leader>r <Plug>(coc-rename)
nmap <Leader>k <Plug>(coc-diagnostic-prev)
nmap <Leader>j <Plug>(coc-diagnostic-next)
nmap <Leader>f <Plug>(coc-fix-current)
nmap <Leader>l :CocDiagnostics<CR>

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Vim command-mode autocompletion
set wildmenu
set wildmode=full
let &wildcharm = &wildchar
cnoremap <C-y> <Down>
cnoremap <C-x> <Up>

" LanguageTool settings
let g:languagetool_jar='$HOME/.vim/languagetool/languagetool-commandline.jar'
let g:languagetool_lang='en'

" Vim file search settings
set grepprg=ag\ -Uf\ --vimgrep\ $*\ --ignore='tags'\ --ignore=*.build.*\ --ignore=*.min.*\ --ignore=*.svg\ --ignore=*.xml\ --ignore=*.log\ --ignore=cache\ --ignore=logs\ --ignore=.git\ --ignore=data\ --ignore=sdk\ --ignore=cordova\ --ignore=dist\ --ignore=node_modules\ --ignore=vendor\ --ignore=.firefox-profile\ --hidden
set grepformat=%f:%l:%c:%m
cnoremap <C-G> silent lgrep! -Q 

" Native fuzzy-finding
set wildignore+=**/node_modules/**
set wildignore+=**/vendor/**
set wildignore+=**/storage/**
set wildignore+=**/cache/**
set wildignore+=**/.git/**
set wildignore+=**/data/**
set path=$PWD/**

" Close preview scratch window on insert leave
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Languages plugins settings
autocmd FileType scss set iskeyword+=-
autocmd FileType blade set iskeyword-=\$
let javascript_enable_domhtmlcss = 1
let g:vim_json_syntax_conceal = 0
autocmd BufRead,BufNewFile *.js set filetype=javascript.jsx
autocmd BufRead,BufNewFile *.pcss set filetype=scss
autocmd BufRead,BufNewFile * set tabstop=4

" NERDTree
nnoremap <silent> <C-N> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
let g:NERDTreeChDirMode=2
let NERDTreeShowHidden=1
let NERDTreeMapOpenSplit='s'
let NERDTreeMapOpenVSplit='v'
let NERDTreeMapQuit=''
let NERDTreeCascadeSingleChildDir=0
let NERDTreeCascadeOpenSingleChildDir=0
let NERDTreeAutoDeleteBuffer=1

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
set t_vb=

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

" Stop annoying reindentation when editing, without disabling reindenting with '='
autocmd BufRead,BufNewFile *.html set indentkeys=''

set ruler

set backspace=indent,eol,start

set noswapfile
set nowritebackup
set mouse=""

set virtualedit=block

set lazyredraw

" Synchronizes default yank with system's clipboard
set clipboard=unnamed,unnamedplus

set timeoutlen=200
set notimeout ttimeout

set t_Co=256
set background=dark
let g:gruvbox_guisp_fallback = "bg"
colorscheme gruvbox

highlight ExtraWhitespace ctermbg=208

" Status bar
set laststatus=2
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_symbols_branch = '⇒'
let g:airline_section_b='%{fnamemodify(getcwd(), '':t'')} > %{airline#util#wrap(airline#extensions#branch#get_head(),0)}'
let g:airline_section_y=''
let g:airline_section_warning=''
set fillchars=vert:▚

autocmd Filetype scss setlocal tabstop=2 shiftwidth=2 softtabstop=2

" EditorConfig settings
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Also clean search results when cleaning screen
nnoremap <silent> <C-L> :noh<CR><C-L>

" Showing tabs
set listchars=tab:▸\ 
set list

if filereadable(expand('~/.vim/local_config.vim'))
    source ~/.vim/local_config.vim
endif

