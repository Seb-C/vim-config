let b:project_unique_name = substitute(getcwd(), "/", "_", "g")
let g:tag_file_location = $HOME.'/.vim/tags/'.b:project_unique_name

" Tags configuration
let g:easytags_async = 1
let g:easytags_always_enabled = 0
let g:easytags_on_cursorhold = 0
let g:easytags_syntax_keyword = 'always'
let g:easytags_file = g:tag_file_location
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
let &tags = g:tag_file_location

" Initializing tags file if not exists in the current project for this language
function CreateTagsFileIfNotExists()
  if !filereadable(g:tag_file_location)
    let g:easytags_async = 0
    :echo "Creating tags index..."
    :UpdateTags -R .
  endif
  let g:easytags_async = 1
endfunction

if len(split(system("ps -o command= -p ".getpid()))) == 1
  " Automatically index project, but not if a specific file
  " has been opened (useful outside projects for example)
  autocmd VimEnter * call CreateTagsFileIfNotExists()
endif

command CreateTags UpdateTags -R .

" TODO remove tag files after a few time ?
