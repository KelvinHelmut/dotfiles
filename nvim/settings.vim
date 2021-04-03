syntax enable                           " Enables syntax highlighing

set number relativenumber               " Line numbers
set laststatus=2                        " Always display the status line
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set tabstop=4                           " Insert 4 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set showtabline=2                       " Always show tabs
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set fileencoding=utf-8                  " The encoding written to file
set ruler              			        " Show the cursor position all the time
set mouse=a                             " Enable your mouse
set cursorline                          " Enable highlighting of the current line
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set clipboard=unnamedplus               " Copy paste between vim and everything else
set background=dark                     " Tell vim what the background color looks like
" set autochdir                           " Your working directory will always be the same as your working directory
set iskeyword+=-                      	" Treat dash separated words as a word text object
set formatoptions-=cro                  " Stop newline continution of comments
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set t_Co=256                            " Support 256 colors
set colorcolumn=101

filetype on
filetype indent on
filetype plugin on
