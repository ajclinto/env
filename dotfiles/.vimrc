syntax on
set autowrite
set cindent
set cino=g0,i0
"set tabstop=8
set tabstop=4

"Settings for side effects
set shiftwidth=4
set softtabstop=4

"Settings for LLVM
"set shiftwidth=2
"set softtabstop=2
"set expandtab

set textwidth=75
set incsearch
set nohlsearch

set ignorecase
set smartcase

"imap <C-j> <ESC>:exec "normal f" . leavechar<CR>a
map <Right> <ESC>:bn<CR>
map <Left> <ESC>:bp<CR>

map ; :
map! <Del> <ESC>

map r <C-d>
map R <C-f>
map t <C-u>
map T <C-b>

map f w

map e :e `~/bin/chhc %`<CR>

map m :!make -j4 PIN_ROOT=$PIN_ROOT<CR>

map ' :q<CR>

map <S-Q> gq

" Abbreviations
iab cst (const char *)
iab cerx cerr << x << endl;
"iab fpr fprintf(stderr, "\n";j;<ESC>hhhhi
iab fpr fprintf(stderr, "\n");<ESC>hhhhi

" Map arrow keys
map <down> <c-e>
map <up> <c-y>

" Map make
map M :mak -j2<CR><CR>
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
