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
            echo 'Failed to find header file.  Aborting.'
            return 0
        endif
        let l:isSrcFile = 1
    endif

    if !s:headerToInlines()
        if l:isSrcFile
            exec ':A'
        endif
    endif

    return 0
endfunction "}}}
