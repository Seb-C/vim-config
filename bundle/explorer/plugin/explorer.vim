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
    autocmd CursorMoved <buffer> :execute "setlocal statusline=" . substitute(fnameescape(getline('.')), "%", "%%", "g")

    " TODO show directories before files (wrong order currently)
    " TODO colours?
    " TODO keep the current buffer position if we reopen it
    " TODO refresh the filelist with <C-L>
    " TODO test the behaviour with Nerdtree / netrw also installed
    " TODO optimize file list generation (+ ignore node_modules/vendor?)
    " TODO loading in background the file list instead of blocking
    " TODO refresh after commands?
    " TODO display bugged if we write a filename in the middle of a directory

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

    write! /tmp/testA
    function TextChanged()
        write! /tmp/testB
        let l:changes = split(system("diff /tmp/testA /tmp/testB -y -W 9999 --suppress-common-lines"), '\r\|\n')
        let l:commands = []

        for l:change in l:changes
            if trim(l:change) == ""
                continue
            endif

            let l:fragments = split(l:change . " ", '[[:space:]]\(|\|<\|>\)[[:space:]]\zs')

            let l:oldName = trim(l:fragments[0][0:-3])
            let l:operator = l:fragments[0][-2:-2]
            let l:newName = trim(get(l:fragments, 1, ""))

            let l:createParentPrefix = ""
            let l:parentDir = fnamemodify(l:newName, ":h")
            if l:parentDir != '.' && !isdirectory(l:parentDir)
                let l:createParentPrefix = "mkdir -p " . l:parentDir . " && "
            endif

            if l:operator == '|'
                call add(l:commands, l:createParentPrefix . "mv " . l:oldName . " " . l:newName)
            elseif l:operator == '<'
                if l:oldName[-1:-1] == '/'
                    call add(l:commands, "rm -d " . l:oldName)
                else
                    call add(l:commands, "rm " . l:oldName)
                endif
            elseif l:operator == '>'
                if l:newName[-1:-1] == '/'
                    call add(l:commands, "mkdir -p " . l:newName)
                else
                    call add(l:commands, l:createParentPrefix . "touch " . l:newName)
                endif
            else
                " TODO change permissions?
                echoerr "Diff not recognized: " . l:change
            endif
        endfor

        if len(l:commands) > 0
            execute feedkeys(":!" . join(l:commands, " && "), "nt")
        endif

        write! /tmp/testA
    endfunction
endfunction
