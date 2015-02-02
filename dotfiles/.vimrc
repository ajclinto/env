syntax on
set autowrite
set cindent
set cino=g0,i0,(0,W4
"set tabstop=8
set tabstop=4

set shiftwidth=4
set softtabstop=4

"Settings for LLVM
"set shiftwidth=2
"set softtabstop=2
"set expandtab

set nosmartindent

"set textwidth=0
"set wrapmargin=0
"set formatoptions+=l

"set flp+=\\\|^\\*\\s*

set incsearch
set nohlsearch

set ignorecase
set smartcase

set ruler

noremap <Right> <ESC>:bn<CR>
noremap <Left> <ESC>:bp<CR>

"imap <Up> _
"cmap <Up> _

noremap ; :
inoremap <Del> <ESC>
inoremap jk <ESC>

noremap r <C-d>
noremap R <C-f>
noremap t <C-u>
noremap T <C-b>

noremap f w

source ~/bin/chhc.vim
noremap e :exec "e ".Chhc(expand("%"))<CR>

noremap m :!make -j4 PIN_ROOT=$PIN_ROOT<CR>
"noremap m :!mdo %<CR>

noremap _ :!iparse<CR>

noremap ' :q<CR>
noremap " :w<CR>
noremap \ :wq<CR>

noremap <S-Q> gq

" Abbreviations
iab cst (const char *)
iab cerx cerr << x << endl;
iab fpr fprintf(stderr, "\n");<ESC>hhhhi
iab pr printf("\n");<ESC>hhhhi

" Map make
"map M :mak -j2<CR><CR>
"map J :cn<CR>
"map K :cp<CR>

" Markers for lh-cpp
"imap ;j	<Plug>MarkersJumpF
"map ;j	<Plug>MarkersJumpF
"imap ;k	<Plug>MarkersJumpB
"map ;k	<Plug>MarkersJumpB
" imap ;m	<Plug>MarkersMark

let g:c_nl_before_curlyB=0
let c_no_curly_error=1

au BufNewFile,BufRead *.lib set filetype=cpp
