let git_root = system('git rev-parse --show-toplevel')

if v:shell_error
  nnoremap <silent><C-p> :Files<Cr>
else
  nnoremap <silent><C-p> :GFiles<Cr>
endif
nnoremap <silent><C-f> :Rg<Cr>
nnoremap <silent><leader>b :Buffers<CR>

let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 1.0 } }
