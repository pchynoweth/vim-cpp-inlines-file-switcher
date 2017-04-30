if !exists('g:cpp_inlines_file_switcher_inlines_file_suffix')
    let g:cpp_inlines_file_switcher_inlines_file_suffix = '.inl,INLINES.C'
endif

if !exists('g:cpp_inlines_file_switcher_header_extensions')
    let g:cpp_inlines_file_switcher_header_extensions = 'h,hh,hxx,hpp'
endif

command! HEADER call vim_cpp_inlines_file_switcher#switchHeader()
command! INLINES call vim_cpp_inlines_file_switcher#switch()
command! SRC call vim_cpp_inlines_file_switcher#switchSrc()
