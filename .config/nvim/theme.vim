colorscheme onedark

let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256

let g:airline_theme = 'onedark'
let g:airline_powerline_fonts=2
let g:airline#extensions#tabline#enabled = 1

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif
