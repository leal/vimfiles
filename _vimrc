""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"   \\|//    _    _  ___  ______
"    o o      \  /   /   /  /  /
"     U        \/ __/_ _/ _/ _/_
" by Leal - http://linxiao.net
"
" Description: vimrc with dozens of scripts, for linux/windows
" Derive From: Amix - http://www.amix.dk/vim/vimrc.html
"              MetaCosm - http://vi-improved.org/vimrc.php
"              Sidney - http://www.afn.org/~afn39695/sidney.htm
" Last Change: 2013-01-07
" Maintainer:  Leal <linxiao.li AT gmail DOT com>
" SVN Repo:    http://vimming.googlecode.com/
" Version:     1.1301, since 1.0501
"
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
"   *> Spell checking
"   *> Plugin settings
"   ------ *> taglist.vim
"   ------ *> Others
"   *> Cope
"   *> Misc
"
" Usage:
"   1. Create necessary folders and files.
"      $vimdata      x:\vim\vimdata on windows, ~/.vimdata on linux
"       |-- temp        dir to put swap files when :set swapfile
"       |-- backup      dir to put backup files when :set backup
"       |-- diary       dir to store calendar.vim's diaries
"       |-- GetLatest   dir to store getscript.vim's downloads
"       |     `-- GetLatestVimScripts.dat
"       |-- _vim_fav_files       file to store favmenu.vim's items
"       `-- _vim_mru_files       file to store mru.vim's items
"
"   2. Get your favorite scripts on www.vim.org thru getscript.vim.
"
"   3. Get necessary utilities, especially on windows, such as:
"      wget  - http://users.ugent.be/~bpuype/wget/
"      ctags - http://ctags.sf.net/
"
"   4. If you find anything that you couldn't understand, do this:
"      :h keyword OR :helpgrep keyword OR press K (<S-k>) over it.
"
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
  let $VIMRC    = $VIM.'/_vimrc'
  let $vimdata  = $VIM.'/vimdata'
  let bundle    = $VIM.'/.vim/bundle'
else
  let $VIMRC    = $HOME.'/.vimrc'
  let $vimdata  = $HOME.'/.vimdata'
  let bundle    = $HOME.'/.vim/bundle'
endif

filetype off
exec 'set rtp+='.bundle.'/vundle'

call vundle#rc(bundle)

Bundle 'vundle'
Bundle 'a.vim'
Bundle 'taglist.vim'
Bundle 'YankRing.vim'
Bundle 'ervandew/supertab'
Bundle 'tomasr/molokai'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/snipmate-snippets'
Bundle 'garbas/vim-snipmate'
Bundle 'QuickBuf'
Bundle 'Lokaltog/vim-powerline'

let g:Powerline_enabled=1

if g:Powerline_enabled
  set encoding=utf-8
  lan mes zh_CN.utf-8     " for encoding=utf-8
  let g:Powerline_symbols = 'fancy'
  if has("win32")
    try | set gfn=Consolas_for_Powerline_FixedD:h10:cANSI | catch | endtry
  else
    set gfn=Bitstream\ Vera\ Sans\ Mono\ 11
  endif
  "highlight VertSplit ctermbg=234 ctermfg=234
else
  set statusline=\ %F%m%r%h\ %w\ %{&ff}\ \ now:\ %r%{CurDir()}%h\ \ \ pos:\ %l/%L:%c
	  " format the statusline
  if has("win32")
    try | set gfn=Consolas:h10:cANSI | catch | endtry
  else
    set gfn=Bitstream\ Vera\ Sans\ Mono\ 11
  endif
endif

set laststatus=2        " always show the status line

filetype plugin on      " enable filetype plugin
filetype indent on

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
au! BufWritePost [\._]vimrc source $VIMRC

set pastetoggle=<F3>    " when pasting something in, don't indent
set rtp+=$vimdata       " add this to rtp to satisfy getscript.vim
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
  set guioptions-=T
  let psc_style='cool'
  let g:molokai_original = 0
  colo molokai
else
  colo desert
  set background=light
  set t_Co=256          " for vim-powerline
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual cues
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

if has("gui_running")   " highlight cursor line/column
  if v:version >= 700
    hi CursorLine guibg=#333333 
    hi CursorColumn guibg=#333333
  endif
endif

if v:version >= 700     " popmenu color setting
  hi Pmenu guibg=#333333
  hi PmenuSel guibg=#555555 guifg=#ffffff
endif

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
"set backupdir=$vimdata/backup
"set directory=$vimdata/temp
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

map <leader>t2 :set shiftwidth=2<cr>
map <leader>t8 :set shiftwidth=8<cr>
au FileType html,python,vim,javascript setl shiftwidth=2
au FileType html,python,vim,javascript setl tabstop=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  """"""""""""""""""""""""""""""
  " => taglist.vim
  """"""""""""""""""""""""""""""
  if has("win32")
    let Tlist_Ctags_Cmd = $VIM.'\ctags.exe'
  endif
  
  let Tlist_Sort_Type = "name"         " order by
  let Tlist_Use_Right_Window = 1       " split to the right side
  let Tlist_Compart_Format = 1         " show small meny
  let Tlist_Exist_OnlyWindow = 1       " if it's the last, kill it
  let Tlist_File_Fold_Auto_Close = 0   " do not close tags for others
  let Tlist_Enable_Fold_Column = 0     " do not show folding tree
  map <leader>t :Tlist<cr>

  """"""""""""""""""""""""""""""
  " => Others
  """"""""""""""""""""""""""""""
  " a.vim          - alternate files fast (.c -> .h)
  " supertab.vim   - map <Tab> to SuperTab() function
  " lookupfile.vim - filename tags generated by find
  let g:LookupFile_TagExpr = '"./filenametags"'
  let g:LookupFile_DefaultCmd = ':LUBufs'
  " calendar.vim   - folder to store diary
  let g:calendar_diary = $vimdata.'/diary'
  " mru.vim        - file to save mru entries
  let MRU_File = $vimdata.'/_vim_mru_files'
  let MRU_Max_Entries = 20
  " favmenu.vim    - file to save favorite items
  let FAV_File = $vimdata.'/_vim_fav_files'
  " yankring.vim   - map :YRShow
  map <leader>y :YRShow<cr>
  " doxygentoolkit.vim - map :Dox
  map <leader>d :Dox<cr>
  " doxygen.vim    - load doxygen syntax for c/cpp/idl
  "let load_doxygen_syntax = 1
  " vcscommand.vim - svn executable path
  "if has("win32")
  "  let g:VCSCommandSVNExec = 'f:\bin\subversion\bin\svn.exe'
  "endif
  map <C-F11> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>
  map <C-F12> :%!astyle -t -b -S -w -M -p -U<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>n :cn<cr>
map <leader>p :cp<cr>
"map <leader>c :botright cw 10<cr>
"map <c-u> <c-l><c-j>:q<cr>:botright cw 10<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

if has("win32")
  " windows ddk, driver develop kit
  set makeprg=for\ \%c\ in\ (\"pushd\ .\"\ \"setenv\ D:\\foo\\WINDDK\\2600\ chk\"\ \"popd\"\ \"build\ -cZ\"\ \"copy\ i386\\ds30xx.sys\ e:\\work\\X\\i386\")\ do\ call\ \%~c 
endif

"if filereadable($vimdata."/session.vim")
"  au VimEnter * so $vimdata/session.vim
"endif
"au VimLeavePre * mks! $vimdata/session.vim

fu! DoRunPyBuffer2()
pclose! " force preview window closed
setlocal ft=python

" copy the buffer into a new window, then run that buffer through python
sil %y a | below new | sil put a | sil %!python -
" indicate the output window as the current previewwindow
setlocal previewwindow ro nomodifiable nomodified

" back into the original window
winc p
endfu

command! RunPyBuffer call DoRunPyBuffer2()
map <Leader>p :RunPyBuffer<CR>

python << EOF

import vim

def SetBreakpoint():
  import re

  nLine = int(vim.eval('line(".")'))

  strLine = vim.current.line
  strWhite = re.search('^(\s*)', strLine).group(1)

  vim.current.buffer.append(
     "%(space)spdb.set_trace() %(mark)s Breakpoint %(mark)s" %
     {'space':strWhite, 'mark': '#' * 30}, nLine - 1)

  for strLine in vim.current.buffer:
    if strLine == "import pdb":
      break
  else:
    vim.current.buffer.append('import pdb', 0)
    vim.command('normal j1')

vim.command('map <f7> :py SetBreakpoint()<cr>')

def RemoveBreakpoints():
  import re

  nCurrentLine = int(vim.eval('line(".")'))

  nLines = []
  nLine = 1
  for strLine in vim.current.buffer:
    if strLine == 'import pdb' or strLine.lstrip()[:15] == 'pdb.set_trace()':
      nLines.append(nLine)
    nLine += 1

  nLines.reverse()

  for nLine in nLines:
    vim.command('normal %dG' % nLine)
    vim.command('normal dd')
    if nLine < nCurrentLine:
      nCurrentLine -= 1

  vim.command('normal %dG' % nCurrentLine)

vim.command('map <s-f7> :py RemoveBreakpoints()<cr>')

def RunDebugger():
  vim.command('wall')
  strFile = vim.eval("g:mainfile")
  vim.command("!start python -m pdb %s" % strFile)

vim.command('map <s-f12> :py RunDebugger()<cr>')

EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim: set et ft=vim tw=78 tags+=$VIMRUNTIME/doc/tags:
