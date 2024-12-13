scriptencoding utf-8

" Plugin manager, use :PlugInstall to apply changes
call plug#begin()
	" Git-related
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'

	" File browsing
	Plug 'preservim/nerdtree'
	Plug 'Xuyuanp/nerdtree-git-plugin'

	" LSP integration
	Plug 'prabirshrestha/vim-lsp'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
	Plug 'prabirshrestha/asyncomplete-file.vim'

	" Languages integration
	Plug 'sheerun/vim-polyglot' " Highlighting for multiple languages
	Plug 'editorconfig/editorconfig-vim'
	Plug 'vim-vdebug/vdebug'

	" Various tools and commands
	Plug 'tpope/vim-surround'
	Plug 'mbbill/undotree'
	Plug 'KabbAmine/vCoolor.vim'
	Plug 'ap/vim-css-color'

	" Quality of life
	Plug 'vim-airline/vim-airline' " Better status bar on the bottom
	Plug 'vim-scripts/CSApprox' " Color scheme compatibility
	Plug 'romainl/vim-qf' " Quickfix window improvements
	Plug 'ntpeters/vim-better-whitespace' " Highlights trailing whitespaces
call plug#end()

source ~/.vim/config/sessions.vim
source ~/.vim/config/bad-habits.vim
source ~/.vim/config/lsp.vim

let mapleader = "\\"

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

" Native auto completion settings
set completeopt=menu,noinsert,menuone,preview
set complete-=i

" Custom alias
command Gblame Git blame

" Vim command-mode autocompletion
let dfgdfg = "./plugg"
set wildmenu
set wildmode=full
let &wildcharm = &wildchar
cnoremap <C-y> <Down>
cnoremap <C-x> <Up>

" Vim file search settings
set grepprg=ag\ -Uf\ --vimgrep\ $*\ --ignore='tags'\ --ignore=*.build.*\ --ignore=*.min.*\ --ignore=*.svg\ --ignore=*.xml\ --ignore=*.log\ --ignore=cache\ --ignore=logs\ --ignore=.git\ --ignore=data\ --ignore=sdk\ --ignore=cordova\ --ignore=dist\ --ignore=node_modules\ --ignore=.terraform\ --ignore=vendor\ --ignore=.firefox-profile\ --hidden
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
autocmd BufRead,BufNewFile terraform.tfvars set filetype=terraform.vars

" NERDTree
nnoremap <silent> <C-N> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
let g:NERDTreeChDirMode=2
let g:NERDTreeStatusline = 'NERDTree'
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
let g:airline_section_z='%p%% ln %l/%L :%v'
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
