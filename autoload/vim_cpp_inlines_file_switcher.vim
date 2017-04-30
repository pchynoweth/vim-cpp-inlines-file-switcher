" Check if the current file matches a header file extension.
" This function shoud work for a wide variety of naming conventions.
function! s:isHeaderFile() "{{{
    return expand('%:e') =~? '^h.\{0,2\}$'
endfunction "}}}

function! s:isInlinesFile() "{{{
    let l:filepath = expand('%')
    for suf in split(g:cpp_inlines_file_switcher_inlines_file_suffix, ',')
        if l:filepath =~? suf . '$'
            return 1
        endif
    endfor
    return 0
endfunction "}}}

function! s:inlinesToHeader() "{{{
    let l:filepath = expand('%:r') " file path without extension and dot
    for suf in split(g:cpp_inlines_file_switcher_header_extensions, ',')
        let l:file = l:filepath . '.' . suf
        if filewritable(l:file)
            exec ':e ' . l:file
            return 1
        endif
    endfor

    return 0
endfunction "}}}

function! s:headerToInlines() "{{{
    let l:filepath = expand('%:r') " file path without extension and dot
    for suf in split(g:cpp_inlines_file_switcher_inlines_file_suffix, ',')
        let l:file = l:filepath . suf
        if filewritable(l:file)
            exec ':e ' . l:file
            return 1
        endif
    endfor

    return 0
endfunction "}}}

function! vim_cpp_inlines_file_switcher#switch() "{{{
    if s:isInlinesFile()
        call s:inlinesToHeader()
        return 0
    endif

    let l:isSrcFile = 0

    if !s:isHeaderFile()
        if !exists(':A')
            echom 'need a.vim plugin to switch from source file'
            return 0
        endif
        exec ':A'
        if !s:isHeaderFile()
            echom 'Failed to find header file.  Aborting.'
            return 0
        endif
        let l:isSrcFile = 1
    endif

    if !s:headerToInlines()
        if l:isSrcFile
            echom 'No inlines file found'
            exec ':A'
            return 0
        endif
    endif

    return 1
endfunction "}}}

" always jump to source file regardless of the current file type
function! vim_cpp_inlines_file_switcher#switchSrc() "{{{
    if !exists(':A')
        echom 'need a.vim plugin to switch'
        return 0
    endif

    let l:isInl = 0
    if s:isInlinesFile()
        let l:isInl = 1
        call s:inlinesToHeader()
    endif

    if !s:isHeaderFile()
        echom 'No header file found'
        return 0
    endif

    exec ':A'

    if s:isHeaderFile()
        echom 'No source file found'
        if l:isInl
            call s:headerToInlines()
        endif
        return 0
    endif

    return 1
endfunction "}}}

" always jump to header file regardless of the current file type
function! vim_cpp_inlines_file_switcher#switchHeader() "{{{
    if !exists(':A')
        echom 'need a.vim plugin to switch'
        return 0
    endif

    if s:isInlinesFile()
        call s:inlinesToHeader()
    else
        exec ':A'
    endif

    if !s:isHeaderFile()
        echom 'No header file found'
        return 0
    endif

    return 1
endfunction "}}}
