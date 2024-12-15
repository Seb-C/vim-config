" Auto completion settings
set omnifunc=lsp#complete
set completeopt=menu,noinsert,menuone,preview
set complete-=i

" Keybindings for vim-lsp
nmap <Leader>t <Plug>(lsp-type-definition)
nmap <Leader>d <Plug>(lsp-definition)
nmap <Leader>i <Plug>(lsp-implementation)
nmap <Leader>c <Plug>(lsp-references)
nmap <Leader>r <Plug>(lsp-rename)
nmap <Leader>k <Plug>(lsp-previous-diagnostic)
nmap <Leader>j <Plug>(lsp-next-diagnostic)
nmap <Leader>a <Plug>(lsp-code-action-float)
nmap <Leader>f :LspCodeAction quickfix<CR>
nmap <Leader>l :LspDocumentDiagnostics<CR>

" Reduce time to feedback after edit
let g:lsp_semantic_delay = 50

" Customize highlight (mentions of the hovered symbol)
let g:lsp_document_highlight_enabled = 1
let g:lsp_document_highlight_delay = 500
let g:lsp_diagnostics_highlights_insert_mode_enabled = 0

" Configure how to set the errors, warnings...
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 250
let g:lsp_diagnostics_float_insert_mode_enabled = 0
let g:lsp_diagnostics_virtual_text_enabled = 0

" Configuring signs column
set signcolumn=auto
let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_diagnostics_signs_insert_mode_enabled = 1
let g:lsp_diagnostics_signs_error = {'text': '✗'}
let g:lsp_diagnostics_signs_warning = {'text': '⚠️'}
let g:lsp_diagnostics_signs_hint = {'text': '🔍'}
let g:lsp_diagnostics_signs_information = {'text': '🛈'}

" Plugins
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
	\ 'name': 'file',
	\ 'allowlist': ['*'],
	\ 'priority': 10,
	\ 'completor': function('asyncomplete#sources#file#completor')
\ }))

" LSP servers

au User lsp_setup call lsp#register_server({
	\ 'name': 'swift',
	\ 'cmd': {server_info->['sourcekit-lsp']},
	\ 'allowlist': ['swift'],
\ })

au User lsp_setup call lsp#register_server({
	\ 'name': 'go',
	\ 'cmd': {server_info->['gopls']},
	\ 'allowlist': ['go'],
\ })
au User lsp_setup call lsp#register_server({
	\ 'name': 'golangci-lint',
	\ 'cmd': {server_info->['golangci-lint-langserver']},
	\ 'initialization_options': {
		\ 'command': ['golangci-lint', 'run', '--out-format', 'json', '--issues-exit-code=1']
	\ },
	\ 'allowlist': ['go'],
\ })

au user lsp_setup call lsp#register_server({
	\ 'name': 'terraform',
	\ 'cmd': {server_info->['terraform-ls', 'serve']},
	\ 'allowlist': ['terraform', 'terraform.vars'],
\ })

au user lsp_setup call lsp#register_server({
	\ 'name': 'json',
	\ 'cmd': {server_info->['npx', 'vscode-json-languageserver', '--stdio']},
	\ 'allowlist': ['json'],
\ })

" Per-project settings
if substitute(getcwd(), '^.*/', '', '') == "astral-divide"
	au User lsp_setup call lsp#register_server({
		\ 'name': 'go',
		\ 'cmd': {server_info->['make', 'lsp']},
		\ 'allowlist': ['go'],
	\ })
	au User lsp_setup call lsp#register_server({
		\ 'name': 'golangci-lint',
		\ 'cmd': {server_info->['golangci-lint-langserver']},
		\ 'initialization_options': {
			\ 'command': ['make', 'lint-for-lsp']
		\ },
		\ 'allowlist': ['go'],
	\ })
endif