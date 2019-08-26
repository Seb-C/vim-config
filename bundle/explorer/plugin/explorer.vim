command Explorer :call OpenExplorer()

function OpenExplorer()
    " Creating and configuring the explorer's buffer
    new
    setlocal filetype=explorer
    setlocal buftype=nofile

    " Hiding the absolute path and indenting visually
    setlocal conceallevel=2
    setlocal concealcursor=nv

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

    " Disabling the undo while initializing the buffer
    let oldUndoLevels = &undolevels
    set undolevels=-1

    " Listing the files recursively and pasting the contents here
    read !find * -print0 | xargs -0 ls -Fd
    exec "normal! ggdd"

    " Closing all the folds
    exec "normal! ggvG$zCgg"

    " Restoring the undo settings
    let &undolevels = oldUndoLevels
    unlet oldUndoLevels

    " Showing the full filename in the status bar
    autocmd CursorMoved <buffer> :execute "file " . getline('.')

    " TODO handle undo events
    " TODO show directories before files (wrong order currently)
    " TODO file operations (open a command line: rm, mv, mkdir, touch, +permissions?)
    " TODO handle moves in the file operations (multiple files)
    " TODO colours?
    " TODO keep the current buffer position if we reopen it
    " TODO refresh the filelist with <C-L>
    " TODO test the behaviour with Nerdtree / netrw also installed
    " TODO optimize file list generation (+ ignore node_modules/vendor?)

    " TODO loading in background the file list instead of blocking

    function CallAction(timer)
        unlet b:debounceTimer
        call TextChanged()
    endfunction
    function DebounceTextChanged()
        if exists("b:debounceTimer")
            call timer_stop(b:debounceTimer)
            unlet b:debounceTimer
        endif

        let b:debounceTimer = timer_start(700, 'CallAction')
    endfunction

    autocmd TextChanged <buffer> :call DebounceTextChanged()
    autocmd InsertLeave <buffer> :call DebounceTextChanged()

    let b:currentUndoRevision = undotree()["seq_cur"]
    function TextChanged()
        let b:newUndoRevision = undotree()["seq_cur"]
        echo "Called"
        " Go to a revision = :undo rev
    endfunction
endfunction
