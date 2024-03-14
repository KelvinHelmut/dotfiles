call plug#begin('~/.config/nvim/plugged')
    if exists('g:vscode')
        " VSCODE
    else
        Plug 'sheerun/vim-polyglot'                         " Syntax support
        Plug 'neoclide/coc.nvim', {'branch': 'release'}     " Intellisense
        Plug 'preservim/nerdcommenter'                      " Code comments
        " Plug 'preservim/nerdtree'                           " File explorer
        Plug 'airblade/vim-gitgutter'                       " Git diff
        Plug 'joshdick/onedark.vim'                         " Theme
        " Plug 'vim-airline/vim-airline'                      " Status line
        " Plug 'ryanoasis/vim-devicons'                       " Icons
        " Plug 'tiagofumo/vim-nerdtree-syntax-highlight'      " Color icons
        Plug 'christoomey/vim-tmux-navigator'               " Tmux compatible
        " Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
        Plug 'windwp/nvim-autopairs'

        Plug 'nvim-tree/nvim-web-devicons'
        Plug 'nvim-lualine/lualine.nvim'
        Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
        Plug 'nvim-tree/nvim-tree.lua'
    endif
call plug#end()


if exists('g:vscode')
    " VSCODE
else
    source ~/.config/nvim/plugins/coc.vim
    " source ~/.config/nvim/plugins/nerdtree.vim
    source ~/.config/nvim/plugins/nerdcommenter.vim
    source ~/.config/nvim/plugins/gitgutter.vim
    " source ~/.config/nvim/plugins/markdown-preview.vim
    source ~/.config/nvim/plugins/fzf.vim
    source ~/.config/nvim/plugins/autopairs.vim
endif


lua << END
require('lualine').setup {
  options = {
    theme = 'onedark',
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
}
END

set termguicolors
lua << EOF
require("bufferline").setup {
    options = {
        separator_style = 'thick',
        indicator = {
            style = 'none'
        },
        show_close_icon = false,
        always_show_bufferline = false,
        hover = {
            enabled = true,
            delay = 100,
            reveal = {'close'}
        },
    },
}
EOF

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
lua << EOF
require("nvim-tree").setup {
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
}
EOF
map <silent><C-b> :NvimTreeToggle<CR>
