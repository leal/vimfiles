""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  \\|//  leal @github  version 1.2506, since 1.0501
"   o o   Thanks: Amix @github, MetaCosm, Sydney
"    U    vim-plug rules, install git, fzf, ctags, ripgrep

" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has('nvim')
  set nocompatible      " use vim as vim, put at the very start
  set browsedir=buffer  " use the directory of the related buffer
  set pastetoggle=<F3>  " when pasting something in, don't indent
  set history=100       " lines of ':' commands, search history...
  set laststatus=2      " always show the status line
  set autoread          " auto read when a file is changed outside
  set hidden            " allow to change buffer w/o saving
endif
set clipboard+=unnamed  " use register '*' for all y, d, c, p ops
set isk+=$,%,#          " none of these should be word dividers
set confirm             " raise a confirm dialog for changed buffer
set fenc=utf-8          " character encoding for file of the buffer
set fencs=ucs-bom,utf-8,gb18030,gbk,gb2312,cp936
set ffs=unix,dos        " behaves good on both linux and windows
lan mes zh_CN.utf-8     " for encoding=utf-8
set mouse=a             " except TERM screen & SecureCRT's linux
set nowritebackup
set noswapfile

let mapleader = ','     " map <leader> will be ,
let g:mapleader = ','

let $VIMRC   = $HOME ..'/'.. (has('win32') ? '_' : '.') ..'vimrc'
let $vimdata = $HOME ..'/.vim/data'
let $plugged = $HOME ..'/.vim/plug'
set runtimepath+=$plugged
                        " fast editing of .vimrc & saving
nmap <leader>e :e! $VIMRC<cr>
nmap <leader>w :w!<cr>
nmap <leader>fu :se ff=unix<cr>

" => Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable some built-in rtp plugins
let g:loaded_vimballPlugin   = 1
let g:loaded_vimball         = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_tarPlugin       = 1
let g:loaded_zipPlugin       = 1
let g:loaded_2html_plugin    = 1
let g:loaded_gzip            = 1

sil! call plug#begin($plugged)
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes', { 'on': [] }
Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp'] }
Plug 'vim-scripts/YankRing.vim', { 'on': [] }
Plug 'yegappan/taglist', { 'on': ['Tlist'] }
Plug 'ervandew/supertab', { 'on': [] }
Plug 'junegunn/vim-easy-align', { 'on': [] }
Plug 'junegunn/fzf', { 'on': ['FZF'], 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim', { 'on': [] }
Plug 'easymotion/vim-easymotion', { 'on': [] }
call plug#end() " also executes filetype on and syntax enable

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1

if g:airline_powerline_fonts
  if has('win32')
    set gfn=Maple_Mono_NF:h11:cANSI:qDRAFT
    set gfw=Maple_Mono_NF_CN:h11:cGB2312
  endif
else
  set statusline=\ %F%m%r%h\ %w\ %{&ff}\ \ now:\ %r%{getcwd()}%h\ \ \ pos:\ %l/%L:%c
  if has('win32')
    set gfn=Consolas:h12:cANSI
  endif
endif

let Tlist_Sort_Type = 'name'         " taglist.vim, order by
let Tlist_Use_Right_Window = 1       " split to the right side
let Tlist_Compact_Format = 1         " show small meny
let Tlist_Exit_OnlyWindow = 1        " if it's the last, kill it
let Tlist_Enable_Fold_Column = 0     " do not show folding tree
map <leader>t :Tlist<cr>

let g:yankring_history_dir = expand('$vimdata')
map <leader>y :YRShow<cr>

" => Visual cues
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('gui_running')
  set guioptions-=r | set guioptions-=L | set guioptions-=T
  winpos 50 50 | set lines=38 columns=150
  colo molokai
else
  set showtabline=2     " always show the line
  set background=light  " before coloscheme
  set termguicolors     " might need only on windows, set t_Co=256?
  colo desert

  highlight Normal guibg=NONE ctermbg=NONE
  highlight NonText guibg=NONE ctermbg=NONE
endif

if v:version >= 700     " popmenu color setting
  hi Pmenu guibg=#333333
  hi PmenuSel guibg=#555555 guifg=#ffffff
endif

if v:version >= 900
  set wildoptions=pum   " possible completions in popup menu
endif
set wildmenu            " :h and press <Tab> to see what happens
set wig+=*.o,*.pyc      " type of file that will not in wildmenu
set scrolloff=7         " minimal screen lines above/below cursor
set ruler               " show current position along the bottom
set backspace=2         " make backspace work normal
set whichwrap+=<,>,h,l  " allow backspace and cursor keys to wrap
set shortmess=atI       " shorten to avoid 'press a key' prompt
set report=0            " tell us when anything is changed via :...
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
                        " make splitters between windows be blank
set showmatch           " show matching paren when a bracket inserted
set ignorecase          " the case of normal letters is ignored
set hlsearch            " highlight all searched for phrases
set incsearch           " highlight where the typed pattern matches
map <silent> <leader><cr> :noh<cr>
                        " remove the highlight searched phrases
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$
                        " how :set list show
set cursorline

" => Moving around
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" press * to search for v-mode current selection
vn <silent> * :call VisualSearch('f')<cr>

fu! VisualSearch(dir) range
  let l:reg = @"
  exe 'normal! vgvy'
  let l:pat = escape(@", '\\/.*$^~[]')
  let l:pat = substitute(l:pat, '\n$', '', '')
  exe 'normal '.. (a:dir == 'f' ? '/' : '?') .. l:pat ..'^M'
  let @/ = l:pat
  let @" = l:reg
endf

" remap vim 0, space
map 0 ^
map <Space> ?

" smart way to switch between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" use the arrows to do something useful
map <Right> :bn<cr>
map <Left> :bp<cr>
map <Down> <Esc>:Tlist<cr>

" => Cmdline settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" bash like
cno <C-A> <Home>
cno <C-F> <Right>
cno <C-B> <Left>
cno <Esc>f <S-Right>
cno <Esc>b <S-Left>

fu! DeleteTillSlash()
  let g:cmd = getcmdline()
  let l:pat = has('win32') ? '\(.*[\\]\).*' : '\(.*[/]\).*'
  let g:cmd_edited = substitute(g:cmd, l:pat, '\1', '')
  if g:cmd == g:cmd_edited
    let l:pat = has('win32') ? '\(.*[\\\\]\).*[\\\\]' : '\(.*[/]\).*/'
    let g:cmd_edited = substitute(g:cmd, l:pat, '\1', '')
  endif
  return g:cmd_edited
endf
cno $q <C-\>eDeleteTillSlash()<cr>

fu! CurrentFileDir(cmd)
  return a:cmd ..' '.. expand('%:p:h') .. (has('win32') ? '\' : '/')
endf
cno $c <C-\>eCurrentFileDir('e')<cr>
map <leader>c :<C-\>eCurrentFileDir('cd')<cr><cr>

fu! CurrentWord(cmd)
  return a:cmd ..' /'.. expand('<cword>') ..'/ '..'*.h *.c'
endf
cno $v <C-\>eCurrentWord('vimgrep')<cr><Home><S-Right><Right><Right>
map <C-Q> :$v

" => Buffer and tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
exe 'set viminfo+='.. (has('nvim') ? 'n~/.shada' : '!,n~/.viminfo')

au BufReadPost * exe (line('''"') > 0 && line('''"') <= line('$')) ? 'norm ''"' : 'norm $'

" don't close window when deleting a buffer
map <leader>bd :call <SID>BufCloseIt()<cr>

fu! <SID>BufCloseIt()
  let l:cbufnr = bufnr('%')
  exe buflisted(bufnr('#')) ? 'buffer #' : 'bnext'
  exe bufnr('%') != l:cbufnr ?? 'new'
  exe !buflisted(l:cbufnr) ?? ('bdelete! '.. l:cbufnr)
endf

map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

set switchbuf=usetab

" => Text options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4 sts=4 sw=4 " tab spacing
set smarttab             " use tabs at start of a line, spaces elsewhere
set linebreak            " wrap long lines at a character in 'breakat'
set textwidth=500        " maximum width of text that is being inserted
set smartindent          " do smart autoindenting
set autoindent
set formatoptions+=rnmM

" move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

map <A-i> i <Esc>r

fu! DeleteTrailingWS()
  exe 'normal mz'
  %s/\s\+$//ge
  exe 'normal `z'
endf
au BufWrite *.py :call DeleteTrailingWS()

" => Misc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remove the windows ^M
nor <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" remove indenting on empty lines
map <F2> :%s/^\s\+$//g<cr>:noh<cr>''

" super paste
ino <C-V> <Esc>:set paste<cr>mui<C-R>+<Esc>mv'uV'v=:set nopaste<cr>

" select range, hit :call SuperRetab(width)
fu! SuperRetab(width) range
  sil! exe a:firstline ..','.. a:lastline ..'s/\v%(^ *)@<= {'.. a:width ..'}/\t/g'
endf

" :call libcallnr('vimtweak64.dll', 'EnableMaximize', 1)
if has('win32') && has('gui_running')
  fu! SetAlpha(alpha)
    sil! exe ':call libcallnr("vimtweak64.dll", "SetAlpha", '.. a:alpha ..')'
  endf
  au VimEnter * call SetAlpha(210)
endif

augroup lazy_load
  au!
  au InsertEnter * call plug#load('vim-easy-align', 'vim-airline-themes', 'vim-easymotion')
  au InsertEnter * call plug#load('supertab', 'YankRing.vim', 'fzf', 'fzf.vim') | au! lazy_load
augroup end

" vim: set et ft=vim tw=78 ts=2 sw=2 tags+=$VIMRUNTIME/doc/tags:
