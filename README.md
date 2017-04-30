vim-cpp-inlines-file-switcher
=============================

Description
-----------
Lightweight plugin to switch in and out of inlines files. This project works as
an extension to a.vim and allow easy switching to and from inlines files.  I
have also included commands to explicitly move to header or source files
regardless of the current file.

Dependencies
------------
- a.vim

Usage
-----
This plugin support three commands:
- INLINES - switches to the inlines file or header file if within an inlines file.
- SRC - Switches to the source file if in a header or inlines file.   Does nothing from source file.
- HEADER - Switches to the header file if in a source or inlines file.   Does nothing from header file.

Configuration
-------------
The follow configuration options are supported.

Configure the inlines file suffix as follows.  Note that the suffix includes the '.' (dot) character.
This is because many conventions for naming inlines files consist of more than just an extension.
This option is not case sensitive.
```vim
    let g:cpp_inlines_file_switcher_inlines_file_suffix = '.inl,INLINES.C'
```

Configure header file extensions as follows.  This option is not case sensitive.
```vim
    let g:cpp_inlines_file_switcher_header_extensions = 'h,hh,hxx,hpp'
```
Installation
------------
If you're using [Vundle](https://github.com/VundleVim/Vundle.vim),
just add `Plugin 'pchynoweth/vim-cpp-inlines-file-switcher'` to your .vimrc and run `:PluginInstall`.

If you're using [vim-plug](https://github.com/junegunn/vim-plug),
just add `Plug 'pchynoweth/vim-cpp-inlines-file-switcher'` to your .vimrc and run `:PlugInstall`.

If you're using [pathogen](https://github.com/tpope/vim-pathogen),
add this repo to your bundle directory.

License
-------
This project is licensed under the MIT license - see the [LICENSE](LICENSE) for more details.
