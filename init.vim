set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
let mapleader = ";"
"" Rnvimr toggle search
tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
nnoremap <silent> <M-o> :RnvimrToggle<CR>
tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>
"" Equalize window resize
nnoremap <silent><Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent><Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent><Leader>> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent><Leader>< :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
"" Color Scheme
silent! colorscheme gruvbox
"" Tab Navigation
" Map Ctrl-t + arrorws to tab movement
nnoremap <C-t><up> :tabr<cr>
nnoremap <C-t><down> :tabl<cr>
nnoremap <C-t><left> :tabp<cr>
nnoremap <C-t><right> :tabn<cr>
" ISO 8601 Timestamp
command TS put =strftime('%FT%T%z')
nnoremap <F5> "=strftime('%FT%T%z')<CR>P
inoremap <F5> <C-R>=strftime('%FT%T%z')<CR>
" Show actual tab characters
set list
set listchars=tab:>-,space:·,eol:↴
" Set Vim to adjust tabs and file recognition
" Recognize .sls files as yaml
au BufNewFile,BufRead,BufReadPost *.sls set ft=yaml syntax=yaml
" See .template files as yaml
au BufNewFile,BufRead,BufReadPost *.template set ft=yaml syntax=yaml
" Set anything seen as yaml (now .yaml and .sls files) to use two spaces for tab
au FileType yaml set expandtab shiftwidth=2 tabstop=2 softtabstop=2
au FileType sh set expandtab shiftwidth=2 tabstop=2 softtabstop=2
"" Windows split right and below
set splitright
set splitbelow
"" Disable Markdown Syntax concealment
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
