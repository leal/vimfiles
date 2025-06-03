""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  \\|//  leal <linxiao.li AT gmail>
"   o o   version 1.2505, since 1.0501
"    U
" Thanks: Amix - https://github.com/amix/vimrc, MetaCosm, Sydney
" Usage:  vim-plug rules, install git, ctags first esp. on windows
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !has('nvim')
  set nocompatible      " use vim as vim, put at the very start
  set browsedir=buffer  " use the directory of the related buffer
  set pastetoggle=<F3>  " when pasting something in, don't indent
endif
set history=100         " lines of Ex commands, search history ...
set clipboard+=unnamed  " use register '*' for all y, d, c, p ops
set isk+=$,%,#          " none of these should be word dividers
set autoread            " auto read when a file is changed outside
set confirm             " raise a confirm dialog for changed buffer
set fenc=utf-8          " character encoding for file of the buffer
set fencs=ucs-bom,utf-8,gb18030,gbk,gb2312,cp936
set encoding=utf-8
lan mes zh_CN.utf-8     " for encoding=utf-8

if has('win32') | let prefix = '_' | else | let prefix = '.' | endif
let $VIMRC    = $HOME.'/'.prefix.'vimrc'
let $vimdata  = $HOME.'/.vim/data'
let $plugged  = $HOME.'/.vim/plug'
set runtimepath+=$plugged

set laststatus=2        " always show the status line
set nowritebackup
set noswapfile

let mapleader = ","     " set mapleader, then <leader> will be ,
let g:mapleader = ","

" => Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" if you don't need plugins coming with Vim
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
Plug 'vim-scripts/a.vim', { 'on': [] }
Plug 'vim-scripts/YankRing.vim', { 'on': [] }
Plug 'yegappan/taglist', { 'on': ['Tlist'] }
Plug 'ervandew/supertab', { 'on': [] }
Plug 'junegunn/vim-easy-align', { 'on': [] }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim', { 'on': [] }
call plug#end()

filetype plugin on      " enable filetype plugin
filetype indent on

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#disable_rtp_load = 0
let g:airline_extensions = ['tabline', 'keymap', 'quickfix', ]

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

let Tlist_Sort_Type = "name"         " taglist.vim, order by
let Tlist_Use_Right_Window = 1       " split to the right side
let Tlist_Compact_Format = 1         " show small meny
let Tlist_Exit_OnlyWindow = 1        " if it's the last, kill it
let Tlist_Enable_Fold_Column = 0     " do not show folding tree
map <leader>t :Tlist<cr>

let g:yankring_history_dir = expand('$vimdata')
map <leader>y :YRShow<cr>

if $TERM != "linux" && $TERM != "screen"
  set mouse=a           " except screen & SecureCRT's linux terminal
endif
                        " fast saving
nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>
                        " fast editing of the .vimrc
map <leader>e :e! $VIMRC<cr>

set path=.,/usr/include/*, " where gf, ^Wf, :find will search
set tags=./tags,tags    " used by CTRL-] together with ctags
set makeef=error.err    " the errorfile for :make and :grep
set ffs=unix,dos,mac    " behaves good on both linux and windows
nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>

" => Visual cues
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable           " enable syntax hl

if has('gui_running')
  set guioptions-=r | set guioptions-=L | set guioptions-=T
  winpos 50 50 | set lines=38 columns=150
  colo molokai
else
  set background=light  " before coloscheme
  set t_Co=256          " for vim-airline
  colo desert

  set termguicolors     " might no need on Linux or Mac OS
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
set completeopt=menu    " possible ins completions in popup menu
set scrolloff=7         " minimal screen lines above/below cursor
set wildmenu            " :h and press <Tab> to see what happens
set wig=*.o,*.pyc       " type of file that will not in wildmenu
set ruler               " show current position along the bottom
set hidden              " allow to change buffer without saving
set backspace=2         " make backspace work normal
set whichwrap+=<,>,h,l  " allow backspace and cursor keys to wrap
set shortmess=atI       " shorten to avoid 'press a key' prompt
set report=0            " tell us when anything is changed via :...
set fillchars=vert:\ ,stl:\ ,stlnc:\ 
                        " make splitters between windows be blank
set showmatch           " show matching paren when a bracket inserted
set matchtime=2         " how many tenths of a second to blink
set ignorecase          " the case of normal letters is ignored
set hlsearch            " highlight all searched for phrases
set incsearch           " highlight where the typed pattern matches
map <silent> <leader><cr> :noh<cr>
                        " remove the highlight searched phrases
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$
                        " how :set list show
set magic               " set magic on
set cursorline

" => Moving around and tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" from an idea by Michael Naumann
fu! VisualSearch(direction) range
  let l:saved_reg = @"
  exe "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    exe "normal ?" . l:pattern . "^M"
  else
    exe "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endf

" press * or # to search for the current selection (part of word)
vnoremap <silent> * :call VisualSearch('f')<cr>
vnoremap <silent> # :call VisualSearch('b')<cr>

" map space to / and c-space to ?
map <space> /
map <C-space> ?

" smart way to switch between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" actually, the tab does not switch buffers, but this works
map <leader>bd :Bclose<cr>
map <down> <esc>:Tlist<cr>
" use the arrows to do something useful
map <right> :bn<cr>
map <left> :bp<cr>

" tab configuration
map <leader>tn :tabnew %<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
try
  set switchbuf=usetab
  if has('gui_running') | set stal=1 | else | set stal=2 | endif
catch
endtry

" moving fast to front, back and 2 sides ;)
imap <m-$> <esc>$a
imap <m-0> <esc>0i
imap <D-$> <esc>$a
imap <D-0> <esc>0i

" switch to current dir
map <leader>c :cd %:p:h<cr>

" => Editing mappings etc.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remap Vim 0
map 0 ^
map <A-i> i <esc>r

" move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

fu! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endf
au BufWrite *.py :call DeleteTrailingWS()

" => Cmdline settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fu! DeleteTillSlash()
  let g:cmd = getcmdline()
  if has('unix')
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if has('unix')
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif
  return g:cmd_edited
endf

fu! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endf

" smart mappings on the cmdline
cno $h e ~/
cno $j e ./

cno $q <C-\>eDeleteTillSlash()<cr>
cno $c e <C-\>eCurrentFileDir("e")<cr>

cno $tc <C-\>eCurrentFileDir("tabnew")<cr>
cno $th tabnew ~/

fu! CurrentWord(cmd)
  return a:cmd . " /" . expand("<cword>") . "/ " . "*.h *.c"
endf
cno $v <C-\>eCurrentWord("vimgrep")<cr><Home><S-Right><Right><Right>
map <c-q> :$v

" bash like
cno <C-A> <Home>
cno <C-F> <Right>
cno <C-B> <Left>
cno <Esc>b <S-Left>
cno <Esc>f <S-Right>

" => Buffer related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" restore cursor position in previous editing session, :h 'viminfo'
set viminfo='10,\"100,:20,!
if has('nvim') | set viminfo+=n~/.viminfo | else | set viminfo+=n~/.viminfo- | endif

au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" buffer - reverse everything ... :)
map <F8> ggVGg?

" don't close window, when deleting a buffer
command! Bclose call <SID>BufCloseIt()

fu! <SID>BufCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")

  if buflisted(l:alternateBufNum)
    buffer #
  else
    bnext
  endif
  if bufnr("%") == l:currentBufNum
    new
  endif
  if buflisted(l:currentBufNum)
    execute("bdelete! ".l:currentBufNum)
  endif
endf

" => Text options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4           " tab spacing
set softtabstop=4       " unify it
set shiftwidth=4        " unify it
set smarttab            " use tabs at start of a line, spaces elsewhere
set fo=tcrqnmM		      " see help formatoptions (complex)
set linebreak           " wrap long lines at a character in 'breakat'
set textwidth=500       " maximum width of text that is being inserted
set cindent             " do C-style indenting
set autoindent
set smartindent

au FileType html,python,vim,javascript setl shiftwidth=2
au FileType html,python,vim,javascript setl tabstop=2

" => Misc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" remove the windows ^M
noremap <leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" remove indenting on empty lines
map <F2> :%s/\s*$//g<cr>:noh<cr>''

" super paste
inoremap <C-V> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

" select range, hit :call SuperRetab($width) - by p0g and FallingCow
fu! SuperRetab(width) range
  sil! exe a:firstline.','.a:lastline.'s/\v%(^ *)@<= {'. a:width .'}/\t/g'
endf

" :call libcallnr("vimtweak64.dll", "EnableMaximize", 1)
if has('win32') && has('gui_running')
  fu! SetAlpha(alpha)
    sil! exe ':call libcallnr("vimtweak64.dll", "SetAlpha", '. a:alpha .')'
  endf
  au VimEnter * call SetAlpha(210)
endif

augroup lazy_load
  au!
  au InsertEnter * call plug#load('vim-easy-align', 'vim-airline-themes', 'fzf.vim')
  au InsertEnter * call plug#load('supertab', 'YankRing.vim', 'a.vim') | au! lazy_load
augroup end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim: set et ft=vim tw=78 tags+=$VIMRUNTIME/doc/tags:
