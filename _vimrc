""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   \\|//  leal <linxiao.li AT gmail>
"    o o   version 1.2505, since 1.0501
"     U    
" Derive:  Amix - http://www.amix.dk/vim/vimrc.html
"          MetaCosm - http://vi-improved.org/vimrc.php
"          Sidney - http://www.afn.org/~afn39695/sidney.htm
" Section:
" ------------------------------------------------------------------
"   *> General
"   *> Colors and fonts
"   *> Visual cues
"   *> Visual search
"   *> Moving around and tabs
"   *> Parenthesis/bracket expanding
"   *> General abbrevs
"   *> Editing mappings etc.
"   *> Cmdline settings
"   *> Buffer related
"   *> Files and backups
"   *> Text options
"   *> Plugin settings
"   *> Misc
"
" Usage:
"   1. Create necessary folders and files.
"      $vimdata  x:\vim\vimdata on windows, ~/.vimdata on linux
"   2. Get your favorite scripts thru vim-plug
"   3. Get necessary utilities, especially on windows, such as:
"      wget  - http://users.ugent.be/~bpuype/wget/
"      ctags - http://ctags.sf.net/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible        " use vim as vim, put at the very start
map Q gq
						" do not use Ex-mode, use Q for formatting
set history=100         " lines of Ex commands, search history ...
set browsedir=buffer    " use the directory of the related buffer
set clipboard+=unnamed  " use register '*' for all y, d, c, p ops
set isk+=$,%,#          " none of these should be word dividers
set autoread            " auto read when a file is changed outside
set confirm             " raise a confirm dialog for changed buffer
set fenc=utf-8          " character encoding for file of the buffer
set fencs=ucs-bom,utf-8,gb18030,gbk,gb2312,cp936

if has("win32")         " platform dependent
  let $VIMRC    = $HOME.'/_vimrc'
  let $vimdata  = $HOME.'/vimfiles/data'
  let plugged   = $HOME.'/vimfiles/plug'
  "set renderoptions=type:directx,renmode:5,taamode:1
else
  let $VIMRC    = $HOME.'/.vimrc'
  let $vimdata  = $HOME.'/.vim/data'
  let plugged   = $HOME.'/.vim/plug'
endif

filetype off

set encoding=utf-8
lan mes zh_CN.utf-8     " for encoding=utf-8

set laststatus=2        " always show the status line

silent! call plug#begin(plugged)
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/a.vim'
Plug 'vim-scripts/YankRing.vim'
Plug 'yegappan/taglist'
Plug 'ervandew/supertab'
Plug 'tomasr/molokai'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'kien/ctrlp.vim'
call plug#end()

filetype plugin on      " enable filetype plugin
filetype indent on

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1

if g:airline_powerline_fonts
  if has("win32")
    "try | set gfn=Source_Code_Pro_for_Powerline:h11:cANSI | catch | endtry
    "try | set gfn=Sarasa_Term_SC:h11:cANSI:qDRAFT | catch | endtry
    "try | set gfn=JetBrainsMono_NFM:h11:cANSI:qDRAFT | catch | endtry
    "try | set gfw=Sarasa_Term_SC:h11:cGB2312 | catch | endtry
    try | set gfn=Maple_Mono_NF:h11:cANSI:qDRAFT | catch | endtry
    try | set gfw=Maple_Mono_NF_CN:h11:cGB2312 | catch | endtry
  else
    set gfn=Bitstream\ Vera\ Sans\ Mono\ 11
  endif
else
  set statusline=\ %F%m%r%h\ %w\ %{&ff}\ \ now:\ %r%{CurDir()}%h\ \ \ pos:\ %l/%L:%c
  if has("win32")
    try | set gfn=Consolas:h12:cANSI | catch | endtry
  else
    set gfn=Bitstream\ Vera\ Sans\ Mono\ 11
  endif
endif

if $TERM != "linux" && $TERM != "screen"
  set mouse=a           " except screen & SecureCRT's linux terminal
endif

let mapleader = ","     " set mapleader, then <leader> will be ,
let g:mapleader = ","
                        " fast saving
nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

                        " fast sourcing and editing of the .vimrc
map <leader>s :source $VIMRC<cr>
map <leader>e :e! $VIMRC<cr>
"au! BufWritePost [\._]vimrc source $VIMRC

set pastetoggle=<F3>    " when pasting something in, don't indent
set path=.,/usr/include/*, " where gf, ^Wf, :find will search
set tags=./tags,tags    " used by CTRL-] together with ctags
set makeef=error.err    " the errorfile for :make and :grep
set ffs=unix,dos,mac    " behaves good under both linux/windows
nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable           " enable syntax hl

if has("gui_running")
  set guioptions-=r
  set guioptions-=L
  set guioptions-=T
  let psc_style='cool'
  let g:molokai_original = 0
  colo molokai
  if v:version >= 700 " highlight cursor line/column
    hi CursorLine guibg=#333333 
    hi CursorColumn guibg=#333333
  endif
else
  colo desert
  set background=light
  set t_Co=256          " for vim-powerline or vim-airline
endif

if v:version >= 700     " popmenu color setting
  hi Pmenu guibg=#333333
  hi PmenuSel guibg=#555555 guifg=#ffffff
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual cues
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cursorline
set scrolloff=7         " minimal screen lines above/below cursor
set wildmenu            " :h and press <Tab> to see what happens
set wig=*.o,*.pyc       " type of file that will not in wildmenu
set ruler               " show current position along the bottom
set cmdheight=1         " use 1 screen lines for command-line
set nolazyredraw        " redraw while executing macros (for qbuf)
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
set novisualbell        " no visual bell, no beeping
set noerrorbells        " do not make noise
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$
                        " how :set list show
set magic               " set magic on
set completeopt=menu    " use popup menu to show possible completions
set foldenable          " enable folding, I find it very useful
set foldmethod=manual   " manual, marker, syntax, try set foldcolumn=2

fu! CurDir()
  let curdir = tolower(substitute(getcwd(), '$HOME', "~/", "g"))
  return curdir
endf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" from an idea by Michael Naumann
fu! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  else
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endf

" press * or # to search for the current selection (part of word)
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around and tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map space to / and c-space to ?
map <space> /
map <C-space> ?

" smart way to switch between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" actually, the tab does not switch buffers, but my arrows
" bclose function can be found in "Buffer related" section
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
  if has("gui_running") | set stal=1 | else | set stal=2 | endif
catch
endtry

" moving fast to front, back and 2 sides ;)
imap <m-$> <esc>$a
imap <m-0> <esc>0i
imap <D-$> <esc>$a
imap <D-0> <esc>0i

" switch to current dir
map <leader>c :cd %:p:h<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $w <esc>`>a"<esc>`<i"<esc>

" map auto complete of (, [, {, ', "
inoremap $1 ()<esc>:let leavechar=")"<cr>i
inoremap $2 []<esc>:let leavechar="]"<cr>i
inoremap $3 {}<esc>:let leavechar="}"<cr>i
inoremap $4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap $q ''<esc>:let leavechar="'"<cr>i
inoremap $w ""<esc>:let leavechar='"'<cr>i
imap <m-l> <esc>:exec "normal f" . leavechar<cr>a
au BufNewFile,BufRead *.\(vim\)\@! inoremap " ""<esc>:let leavechar='"'<cr>i
au BufNewFile,BufRead *.\(txt\)\@! inoremap ' ''<esc>:let leavechar="'"<cr>i

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General abbrevs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xtime <c-r>=strftime("%Y-%m-%d %H:%M:%S")<cr>
iab xdate <c-r>=strftime("%Y-%m-%d")<cr>
iab xname Linxiao Li

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cmdline settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fu! DeleteTillSlash()
  let g:cmd = getcmdline()
  if has("unix")
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if has("unix")
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffer related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fast open a buffer by search for a name
"map <c-q> :sb 
" open a dummy buffer for paste
map <leader>q :e ~/buffer<cr>

" restore cursor position in previous editing session, :h 'viminfo'
set viminfo='10,\"100,:20,!,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" buffer - reverse everything ... :)
map <F8> ggVGg?

" don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

fu! <SID>BufcloseCloseIt()
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowritebackup
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noexpandtab         " real tabs please!
set tabstop=4           " tab spacing
set softtabstop=4       " unify it
set shiftwidth=4        " unify it
set smarttab            " use tabs at start of a line, spaces elsewhere
set fo=tcrqnmM		      " see help formatoptions (complex)
set linebreak           " wrap long lines at a character in 'breakat'
set textwidth=500       " maximum width of text that is being inserted
set ai                  " autoindent
set si                  " smartindent
set cindent             " do C-style indenting
set wrap                " wrap lines

au FileType html,python,vim,javascript setl shiftwidth=2
au FileType html,python,vim,javascript setl tabstop=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " taglist.vim
  let Tlist_Sort_Type = "name"         " order by
  let Tlist_Use_Right_Window = 1       " split to the right side
  let Tlist_Compact_Format = 1         " show small meny
  let Tlist_Exit_OnlyWindow = 1        " if it's the last, kill it
  let Tlist_File_Fold_Auto_Close = 0   " do not close tags for others
  let Tlist_Enable_Fold_Column = 0     " do not show folding tree
  map <leader>t :Tlist<cr>

  " a.vim          - alternate files fast (.c -> .h)
  " supertab.vim   - map <Tab> to SuperTab() function
  " lookupfile.vim - filename tags generated by find
  let g:LookupFile_TagExpr = '"./filenametags"'
  let g:LookupFile_DefaultCmd = ':LUBufs'
  " mru.vim        - file to save mru entries
  let MRU_File = $vimdata.'/_vim_mru_files'
  let MRU_Max_Entries = 20
  " favmenu.vim    - file to save favorite items
  let FAV_File = $vimdata.'/_vim_fav_files'
  " yankring.vim   - map :YRShow
  map <leader>y :YRShow<cr>
  let g:yankring_history_dir = expand('$vimdata')
  " doxygentoolkit.vim - map :Dox
  map <leader>d :Dox<cr>

  map <C-F11> :!ctags -R --c++-kinds=+p --fields=+iaS --extras=+q .<cr>
  map <C-F12> :%!astyle -t -b -S -w -M -p -U<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>n :cn<cr>
map <leader>p :cp<cr>

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

" inserts links & anchors on a TOhtml export.
" Usage:
"   *> Link
"   => Anchor
fu! SmartTOhtml()
  let g:html_use_encoding = toupper(&fileencoding)
  let g:html_use_css = 1
  TOhtml
  try
    %s/&quot;\s\+\*&gt; \(.\+\)</" <a href="#\1" style="color: cyan">\1<\/a></g
    %s/&quot;\(-\|\s\)\+\*&gt; \(.\+\)</" \&nbsp;\&nbsp; <a href="#\2" style="color: cyan;">\2<\/a></g
    %s/&quot;\s\+=&gt; \(.\+\)</" <a name="\1" style="color: #fff">\1<\/a></g
  catch
  endtry
  exe ":w!"
  exe ":bd"
endf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim: set et ft=vim tw=78 tags+=$VIMRUNTIME/doc/tags:
