" Moving line by line even if wrapped
" map <buffer> j gj
" map <buffer> k gk

" Adds undo points on every punctuation
inoremap <buffer> . .<C-g>u
inoremap <buffer> ! !<C-g>u
inoremap <buffer> ? ?<C-g>u
inoremap <buffer> : :<C-g>u

" Enable spell-checking
setlocal spell
setlocal spelllang=en
