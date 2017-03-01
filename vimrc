execute pathogen#infect()
set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins
set omnifunc=syntaxcomplete#Complete " Enable omni competion
set tabstop=2         " Enable tabstop, tab counts for 2 columns
set shiftwidth=2      " Enable reindent as two spaces
set expandtab         " Enable tab in insert mode
set number            " Show line numbers
set autoindent        " Enable autoindent
set hlsearch          " Hightlight search maches
set t_Co=256          " Set to 256 colors
colorscheme elflord   " Enable colorscheme
let mapleader = ","   " Remap the leader key to the comma key
set laststatus=2      " Run vim-airline
set iskeyword+=-      " Set word definition to include dash

" start nerdtree when vim starts
autocmd VimEnter * NERDTree | wincmd p

" automatically enter paste mode when pasting
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" function to toggle line numbers
function! NumberToggle()
if(&relativenumber == 1)
set norelativenumber
set number
else
set number
set relativenumber
endif
endfunc

" Use vim hard mode plugin by default
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()


" Leader l - toggles relative line number mode
nnoremap <Leader>l :call NumberToggle()<CR>

" Leader s - saves the file
map <Leader>s :w<CR>

" Disable ctrlp working directory - current dir is used
let g:ctrlp_working_path_mode = 'r'

" ctrlp ignore settings
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Use K to search for work under the cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
nnoremap \ :Ag<SPACE>
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" Syntastic defaults
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"" remap quickfix open horizontal split
let g:qfenter_hopen_map = ['<c-x>']
