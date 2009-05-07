" .vimrc
" By Hicham Romane
" At 2009-04-30


function SetVisualPreferences()
  syntax on
  set nowrap
  set number
  set mouse=a
  set textwidth=80 
  colorscheme elflord 
  if has("gui_running")
      set guifont=Monospace\ 10 " use this font
      set lines=50              " height = 50 lines
      set columns=80            " width = 80 columns
      set background=light      " adapt colors for background
      set selectmode=mouse,key,cmd
      set keymodel=
  else
      set background=dark        " adapt colors for background
  endif
endfunction

function UsePreferedIndentation()
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
  set expandtab
  set backspace=indent,eol,start  " backspace over anything
endfunction

function UseAutomaticIndentation()
  set autoindent
  set smartindent
  set cindent
endfunction

function UseDefaultEncoding()
  set encoding=utf-8 nobomb    " BOM often causes trouble
  set tenc=utf8
  set fileencoding=utf8
endfunction

function SetSearchPreferences()
  set gdefault                 " global search/replace by default
  set ignorecase               " ignore case when searching
  set smartcase                " override ignorecase when there are uppercase characters
  set incsearch hlsearch       " highlight search matches
  set showmatch			           " when inserting a bracked briefly flash its match
endfunction

function CloseAllCommentsFolds()
  "by Andreas Politz
  set fdm=expr
  set fde=getline(v:lnum)=~'^\\s*#'?1:getline(prevnonblank(v:lnum))=~'^\\s*#'?1:getline(nextnonblank(v:lnum))=~'^\\s*#'?1:0
endfunction

function SetBackupFolder()
  set backup
  set backupdir=$HOME/.vim/backup
endfunction

function InitializeRunningCommands()
  call SetVisualPreferences()
  call UsePreferedIndentation()
  call UseAutomaticIndentation()
  call UseDefaultEncoding()
  call SetSearchPreferences()
  call CloseAllCommentsFolds()
  call SetBackupFolder()
endfunction

call InitializeRunningCommands()
