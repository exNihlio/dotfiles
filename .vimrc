if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup fedora
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

if &term=="screen-256color"
    set t_Co=256
endif

if &term=="xterm-256color"
    set t_Co=256
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"
""""""""""""""""""""""""""
" User specific settings "
""""""""""""""""""""""""""
" Number line
set nu

"We want a dark background
set background=dark
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" netrw stuff
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
"" When Vim first starts up, open netrw in vertical explore
augroup ProjectDrawer
  autocmd!
  autocmd VimEnter * :Vexplore
augroup END
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

" Set color scheme here
silent! colorscheme gruvbox

" Vertical split windows to the right and
" horizontal split windows below.
set splitright
set splitbelow

" Map Ctrl-t + arrorws to tab movement
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>
" ISO 8601 Timestamp
command TS put =strftime('%FT%T%z')
nnoremap <F5> "=strftime('%FT%T%z')<CR>P
inoremap <F5> <C-R>=strftime('%FT%T%z')<CR>
