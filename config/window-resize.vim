" Submode to ease window resizing
let g:submode_timeout = 0
let g:submode_keep_leaving_key = 1
call submode#enter_with('WindowControl', 'n', '', '<C-q>')
silent !stty -ixon

" Normal resizing
call submode#map('WindowControl', 'n', '', '+', ':resize +3<Enter>')
call submode#map('WindowControl', 'n', '', '-', ':resize -3<Enter>')
call submode#map('WindowControl', 'n', '', '>', ':vertical resize +3<Enter>')
call submode#map('WindowControl', 'n', '', '<lt>', ':vertical resize -3<Enter>')

" Moving window
call submode#map('WindowControl', 'n', '', 'h', '<C-w>h<C-w><lt><C-W>l<C-W><lt>')
call submode#map('WindowControl', 'n', '', 'l', '<C-w>h<C-w>><C-W>l<C-W>>')
call submode#map('WindowControl', 'n', '', 'k', '<C-w>k<C-w>-<C-W>j<C-W>-')
call submode#map('WindowControl', 'n', '', 'j', '<C-w>k<C-w>+<C-W>j<C-W>+')
