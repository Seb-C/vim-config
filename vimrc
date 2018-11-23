" Plugin manager
execute pathogen#infect()
syntax on

let b:project_unique_name = substitute(getcwd(), "/", "_", "g")
let b:tag_file_location = $HOME.'/.vim/tags/'.b:project_unique_name
let g:session_file_location = $HOME.'/.vim/sessions/'.b:project_unique_name

" Tags configuration
let g:easytags_async = 1
let g:easytags_always_enabled = 0
let g:easytags_on_cursorhold = 0
let g:easytags_syntax_keyword = 'always'
let g:easytags_file = b:tag_file_location
let g:easytags_auto_update = 0
let g:easytags_auto_highlight = 0
let g:easytags_resolve_links = 1
let g:easytags_cmd = '/usr/local/bin/ctags'
let g:easytags_opts = [
  \ '--exclude=*-min.*',
  \ '--exclude=*.log',
  \ '--exclude=*.min.*',
  \ '--exclude=.git',
  \ '--exclude=bundle.js',
  \ '--exclude=cache',
  \ '--exclude=data',
  \ '--exclude=tags',
  \ '--exclude=dist',
  \ '--exclude=logs',
  \ '--exclude=minified',
  \ '--exclude=node_modules',
  \ '--exclude=tinymce',
  \ '--exclude=wmd.js',
  \ '--exclude=*.json',
  \ '--exclude=*.css',
  \ '--exclude=lang',
  \ '--exclude=select2',
  \ '--exclude=*vendor/**/tests',
  \ '--exclude=*vendor/**/Tests',
  \ '--exclude=*vendor/**/*.js',
  \ '--exclude=*packages/**/*.js',
  \ '--fields=+aimlS-s',
  \ '--JavaScript-kinds=-v'
\ ]
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
autocmd BufWritePost * UpdateTags
noremap <C-x><C-t> :TagbarToggle<CR>
let &tags = b:tag_file_location

" Tabularize custom configuration
autocmd VimEnter * AddTabularPattern , /[^,]\+,
cnoreabbrev Align Tabularize

" Storing undo
set undodir=$HOME/.vim/undo
set undofile
set undolevels=1000
set undoreload=1000
command Undotree UndotreeShow

" Initializing tags file if not exists in the current project for this language
function CreateTagsFileIfNotExists()
  if !filereadable(b:tag_file_location)
    let g:easytags_async = 0
    :echo "Creating tags index..."
    :UpdateTags -R .
  endif
  let g:easytags_async = 1
endfunction

" Session handling
command SaveSession :execute 'mksession! '.g:session_file_location
command DeleteSession :call delete(g:session_file_location)
function OpenSessionIfExists()
  if filereadable(g:session_file_location)
    execute 'source '.g:session_file_location
  endif
endfunction

if len(split(system("ps -o command= -p ".getpid()))) == 1
  " Automatically index project, but not if a specific file
  " has been opened (useful outside projects for example)
  autocmd VimEnter * call CreateTagsFileIfNotExists()

  " Same for sessions handling. We don't want to open the
  " environment if a specific file has been opened
  autocmd VimEnter * call OpenSessionIfExists()
endif

" TODO remove tag files after a few time ?

" Search shortcut command
fu! SearchInProject(pattern)
  silent execute "silent !(ag -QUf --vimgrep ".a:pattern." --ignore='tags' --ignore=*.min.* --ignore=*.log --ignore=cache --ignore=logs --ignore=.git --ignore=data --ignore=dist --ignore=cordova --ignore=node_modules | cut -c1-1024 > /tmp/vim-grep)"
  lfile /tmp/vim-grep
  lopen
  redraw!
  set nowrap
endfunction
command -nargs=1 Search call SearchInProject(shellescape("<args>", 1))
autocmd BufWinEnter quickfix nmap <buffer> s <C-W><CR><C-W>K
autocmd BufWinEnter quickfix nmap <buffer> S <C-W><CR><C-W>K<C-W>b
autocmd BufWinEnter quickfix nmap <buffer> v <C-W><CR><C-W>H<C-W>b<C-W>t
autocmd BufWinEnter quickfix nmap <buffer> V <C-W><CR><C-W>H<C-W>b

" vim-qf config
let g:qf_window_bottom = 0
let g:qf_loclist_window_bottom = 0

" Custom Terminal command
command Terminal :ConqueTerm bash
let g:ConqueTerm_StartMessages = 0

" Enabling aliases (might need to add "shopt -s expand_aliases" in top of ~/.bash_aliases file)
let $BASH_ENV = "~/.bash_aliases"

" create some aliases just for simplicity
command Ghistory Agit
command CreateTags UpdateTags -R .

" Auto completion settings
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
set completeopt=menu,noinsert,menuone,preview
let g:acp_EnableAtStartup = 1
let g:acp_completeoptPreview = 1
set complete-=i
let g:acp_completeOption = &complete

" Vim commands autocompletion
set wildmenu
set wildmode=full

" HTML and view files settings
au BufRead,BufNewFile *.view.php,*.tpl set filetype=phtml
autocmd FileType html,phtml set omnifunc=htmlcomplete#CompleteTags

" Close preview scratch window on insert leave
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Languages plugins settings
autocmd FileType scss set iskeyword+=-
let g:phpcomplete_parse_docblock_comments = 1
let g:phpcomplete_enhance_jump_to_definition = 0
let g:phpcomplete_relax_static_constraint = 1
let g:phpcomplete_complete_for_unknown_classes = 0
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
set mouse=n

set virtualedit=block

" Synchronizes default yank with system's clipboard
set clipboard=unnamedplus

set timeoutlen=200

" Active window minimal size
set winheight=20
set winwidth=70

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
let g:airline_section_y=''
let g:airline_section_warning=''
set fillchars=vert:▚

" Rainbow parentheses
let g:rainbow_active = 0
let g:airline_section_y .= ' %{RedrawStatusLineForRainbow(mode())}'
function! RedrawStatusLineForRainbow(mode)
    if a:mode == 'n' || a:mode == 'i' || a:mode == 'R'
        RainbowToggleOff
    elseif a:mode == 'v' || a:mode == 'V' || a:mode == '^V'
        RainbowToggleOn
    endif
    redraw
    return ''
endfunction

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

" EditorConfig settings
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Linters
let g:syntastic_php_checkers = ['php']
let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = './node_modules/.bin/eslint'
let g:syntastic_auto_loc_list = 1
if filereadable('.php_cs') && filereadable('./vendor/friendsofphp/php-cs-fixer/php-cs-fixer')
    let g:php_cs_fixer_config_file = '.php_cs'
    let g:php_cs_fixer_path = './vendor/friendsofphp/php-cs-fixer/php-cs-fixer --allow-risky=yes'
    autocmd BufWritePost *.php call PhpCsFixerFixFile()
endif

" Also clean search results when cleaning screen
nnoremap <silent> <C-L> :noh<CR><C-L>

" Showing tabs
set listchars=tab:▸\ 
set list

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
nmap <ScrollWheelUp> <nop>
nmap <S-ScrollWheelUp> <nop>
nmap <C-ScrollWheelUp> <nop>
nmap <ScrollWheelDown> <nop>
nmap <S-ScrollWheelDown> <nop>
nmap <C-ScrollWheelDown> <nop>
nmap <ScrollWheelLeft> <nop>
nmap <S-ScrollWheelLeft> <nop>
nmap <C-ScrollWheelLeft> <nop>
nmap <ScrollWheelRight> <nop>
nmap <S-ScrollWheelRight> <nop>
nmap <C-ScrollWheelRight> <nop>

" Some specific keys to make vim easier with an AZERTY keyboard
if system("setxkbmap -print | grep xkb_symbols | awk '{print $4}' | awk -F'+' '{print $2}'") =~ "fr"
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
endif
" M is not in the middle on an AZERTY keyboard, so we use K
" instead (default = Help, but who needs help anyway ;D )
"noremap K M

" To go on a mark, use M, to save a mark, use m
"noremap M '

" Use ù to use a macro, since @ is not easy to reach on an AZERTY
"noremap ù @

