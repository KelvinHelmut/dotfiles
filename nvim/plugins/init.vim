call plug#begin('~/.config/nvim/plugged')
    if exists('g:vscode')
        " VSCODE
    else
        Plug 'sheerun/vim-polyglot'                         " Syntax support
        Plug 'neoclide/coc.nvim', {'branch': 'release'}     " Intellisense
        Plug 'preservim/nerdcommenter'                      " Code comments
        Plug 'preservim/nerdtree'                           " File explorer
        Plug 'airblade/vim-gitgutter'                       " Git diff
        Plug 'joshdick/onedark.vim'                         " Theme
        Plug 'vim-airline/vim-airline'                      " Status line
        Plug 'ryanoasis/vim-devicons'                       " Icons
        Plug 'tiagofumo/vim-nerdtree-syntax-highlight'      " Color icons
        Plug 'christoomey/vim-tmux-navigator'               " Tmux compatible
        Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    endif
call plug#end()


if exists('g:vscode')
    " VSCODE
else
    source ~/.config/nvim/plugins/coc.vim
    source ~/.config/nvim/plugins/nerdtree.vim
    source ~/.config/nvim/plugins/nerdcommenter.vim
    source ~/.config/nvim/plugins/gitgutter.vim
    source ~/.config/nvim/plugins/markdown-preview.vim
endif
