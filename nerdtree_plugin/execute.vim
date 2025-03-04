call NERDTreeAddMenuItem({
	\ 'text': 'e(x)ecute',
	\ 'shortcut': 'x',
	\ 'callback': 'NERDTreeExecute'
\ })

function! NERDTreeExecute()
  let path = g:NERDTreeFileNode.GetSelected().path.str()
  execute "silent !open " . shellescape(path, 1) . " > /dev/null 2>&1 &"
  redraw!
endfunction
