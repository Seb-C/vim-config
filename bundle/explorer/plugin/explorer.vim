command Explorer :call OpenExplorer()

function OpenExplorer()
    " Creating and configuring the explorer's buffer
    new
    setlocal filetype=explorer
    setlocal buftype=nofile

    " Hiding the absolute path and indenting visually
    setlocal conceallevel=2
    setlocal concealcursor=nvi

    " Folding files depending on the depth of the path
    setlocal foldmethod=expr
    setlocal foldexpr=ExplorerFoldExpr()
    function ExplorerFileDepth(line)
        return strlen(substitute(a:line, "[^/]", "", "g"))
    endfunction
    function ExplorerFoldExpr()
        let l:line = getline(v:lnum)
        if l:line[strlen(l:line) - 1] == '/'
            return '>' . ExplorerFileDepth(l:line)
        endif

        return ExplorerFileDepth(l:line)
    endfunction
    setlocal foldminlines=0
    set foldtext=ExplorerFoldText()
    function ExplorerFoldText()
        return substitute(getline(v:foldstart), "[^/]\\+/\\($\\)\\@!", "| ", "g")
    endfunction

    " Listing the files recursively and pasting the contents here
    read !find * -print0 | xargs -0 ls -Fd
    exec "normal! ggdd"

    " Closing all the folds
    exec "normal! ggvG$zCgg"

    " Showing the full filename in the status bar
    autocmd CursorMoved <buffer> :execute "file " . getline('.')

    " TODO show directories before files (wrong order currently)
    " TODO file operations (open a command line: rm, mv, mkdir, touch, +permissions?)
    " TODO handle moves in the file operations (multiple files)
    "      events to test: TextChanged, TextChangedI, TextChangedP, TextYankPost
    " TODO readonly buffer
    " TODO colours?
    " TODO keep the current buffer position if we reopen it
    " TODO refresh the filelist with <C-L>
endfunction
