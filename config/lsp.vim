set omnifunc=ale#completion#OmniFunc
set completeopt=menu,noinsert,noselect,menuone,preview
set complete-=i

let g:ale_linters_explicit = 1
let g:ale_linters = {
	\ 'go': ['gopls'],
	\ 'swift': ['sourcekitlsp'],
\ }

let g:ale_completion_enabled = 1

let g:ale_cursor_detail = 1
let g:ale_virtualtext_cursor = 'disabled'

let g:ale_floating_preview = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']

set splitbelow

" Fix location list for c, d, t, i
" TODO enable right linters
" TODO specific config for astral divide
" display window after completion

nmap <Leader>t :ALEGoToTypeDefinition<CR>
nmap <Leader>d :ALEGoToDefinition<CR>
nmap <Leader>i :ALEGoToImplementation<CR>
nmap <Leader>c :ALEFindReferences -relative<CR>
nmap <Leader>r :ALERename<CR>
nmap <Leader>k :ALEPreviousWrap<CR>
nmap <Leader>j :ALENextWrap<CR>
nmap <Leader>a :ALECodeAction<CR>
nmap <Leader>f :ALEImport<CR>
nmap <Leader>l :ALEPopulateLocList<CR>

" Plugins
"au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
"	\ 'name': 'file',
"	\ 'allowlist': ['*'],
"	\ 'priority': 10,
"	\ 'completor': function('asyncomplete#sources#file#completor')
"\ }))
"
"" LSP servers
"
"au User lsp_setup call lsp#register_server({
"	\ 'name': 'swift',
"	\ 'cmd': {server_info->['sourcekit-lsp']},
"	\ 'allowlist': ['swift'],
"	\ 'initialization_options': {
"		\ 'swiftPublishDiagnosticsDebounceDuration': 0,
"	\ },
"\ })
"
"au User lsp_setup call lsp#register_server({
"	\ 'name': 'rust',
"	\ 'cmd': {server_info->['rust-analyzer']},
"	\ 'allowlist': ['rust'],
"	\ 'initialization_options': {
"		\ 'completion': {
"			\ 'autoimport': { 'enable': v:true },
"		\ },
"	\ },
"\ })
"
"au User lsp_setup call lsp#register_server({
"	\ 'name': 'go',
"	\ 'cmd': {server_info->['gopls']},
"	\ 'allowlist': ['go'],
"\ })
"au User lsp_setup call lsp#register_server({
"	\ 'name': 'golangci-lint',
"	\ 'cmd': {server_info->['golangci-lint-langserver']},
"	\ 'initialization_options': {
"		\ 'command': ['golangci-lint', 'run', '--out-format', 'json', '--issues-exit-code=1']
"	\ },
"	\ 'allowlist': ['go'],
"\ })
"
"au user lsp_setup call lsp#register_server({
"	\ 'name': 'terraform',
"	\ 'cmd': {server_info->['terraform-ls', 'serve']},
"	\ 'allowlist': ['terraform', 'terraform.vars'],
"\ })
"
"au user lsp_setup call lsp#register_server({
"	\ 'name': 'json',
"	\ 'cmd': {server_info->['npx', 'vscode-json-languageserver', '--stdio']},
"	\ 'allowlist': ['json'],
"\ })
"
"" Per-project settings
"if substitute(getcwd(), '^.*/', '', '') == 'astral-divide'
"	au User lsp_setup call lsp#register_server({
"		\ 'name': 'go',
"		\ 'cmd': {server_info->['make', 'lsp']},
"		\ 'allowlist': ['go'],
"	\ })
"	au User lsp_setup call lsp#register_server({
"		\ 'name': 'golangci-lint',
"		\ 'cmd': {server_info->['golangci-lint-langserver']},
"		\ 'initialization_options': {
"			\ 'command': ['make', 'lint-for-lsp']
"		\ },
"		\ 'allowlist': ['go'],
"	\ })
"endif
