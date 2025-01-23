scriptencoding utf-8

" Must be configured before loading the gruvbox plugin
let g:gruvbox_bold = 1
let g:gruvbox_italics = 0
let g:gruvbox_italicize_strings = 0
let g:gruvbox_plugin_hi_groups = 0 " Breaks compatibility with NERDTree

" Plugin manager, use :PlugInstall to apply changes
call plug#begin()
	" Git-related
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'

	" File browsing
	Plug 'preservim/nerdtree'
	Plug 'Xuyuanp/nerdtree-git-plugin'

	" Languages integration
	Plug 'neoclide/coc.nvim', {'branch': 'release'} " LSP integration
	Plug 'sheerun/vim-polyglot' " Highlighting for multiple languages
	Plug 'editorconfig/editorconfig-vim'
	Plug 'vim-vdebug/vdebug'

	" Various tools and commands
	Plug 'tpope/vim-surround'
	Plug 'mbbill/undotree'
	Plug 'KabbAmine/vCoolor.vim'
	Plug 'ap/vim-css-color'

	" Color and style
	Plug 'lifepillar/vim-gruvbox8' " Color scheme itself
	Plug 'vim-airline/vim-airline' " Better status bar on the bottom

	" Quality of life
	Plug 'romainl/vim-qf' " Quickfix window improvements
	Plug 'ntpeters/vim-better-whitespace' " Highlights trailing whitespaces
call plug#end()

source ~/.vim/config/sessions.vim
source ~/.vim/config/bad-habits.vim

let mapleader = "\\"

" Omni complete options
set omnifunc=syntaxcomplete#Complete
set completeopt=menu,noinsert,noselect,menuone,preview
set complete-=i

" rust-analyzer does not work in standalone, could not find the reason
let g:coc_global_extensions = ['coc-rust-analyzer', 'coc-json', 'coc-tsserver', 'coc-eslint']

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
nmap <Leader>o :CocOutline<CR>

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

" Custom alias
command Gblame Git blame

" Update git signs immediately on save
autocmd BufWritePost * GitGutter

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
set switchbuf=uselast

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
set termguicolors
set background=dark
colorscheme gruvbox8

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

" Basic netrw settings
let g:netrw_liststyle=3
let g:netrw_banner = 0
let g:netrw_localcopydircmd = 'cp -r'
let g:netrw_browse_split = 0
let g:netrw_altfile = 0
let g:netrw_hide = 0

" Workaround to keep the netrw cursor position when reopening
let g:last_netrw_position = 3
nmap <Leader>n :exec 'Explore' getcwd()<CR>:exec g:last_netrw_position<CR>
autocmd FileType netrw autocmd BufLeave <buffer> let g:last_netrw_position = line(".")

" TODO git integration with signs? https://vim-jp.org/vimdoc-en/sign.html
" TODO check and configure basic actions
" TODO replace main shortcut to open it (CTRL-N)?
