fu! SearchInProject(pattern)
  silent execute "silent !(ag -QUf --vimgrep ".a:pattern." --ignore='tags' --ignore=*.min.* --ignore=*.log --ignore=cache --ignore=logs --ignore=.git --ignore=data --ignore=dist --ignore=cordova --ignore=node_modules --ignore=vendor --ignore=phpmetrics --ignore=storage | cut -c1-1024 > /tmp/vim-grep)"
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
