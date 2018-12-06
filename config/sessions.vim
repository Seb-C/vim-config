let b:project_unique_name = substitute(getcwd(), "/", "_", "g")
let g:session_file_location = $HOME.'/.vim/sessions/'.b:project_unique_name

command SaveSession :execute 'mksession! '.g:session_file_location
command DeleteSession :call delete(g:session_file_location)
function OpenSessionIfExists()
  if filereadable(g:session_file_location)
    execute 'source '.g:session_file_location
  endif
endfunction

if len(split(system("ps -o command= -p ".getpid()))) == 1
  " Opening saved session, but not if a specific file has been opened
  autocmd VimEnter * call OpenSessionIfExists()
endif
