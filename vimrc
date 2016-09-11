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
set hlsearch          " Hightlight search maches
set t_Co=256          " Set to 256 colors
colorscheme default   " Enable colorscheme
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

" Leader l - toggles relative line number mode
nnoremap <Leader>l :call NumberToggle()<CR>

" Leader s - saves the file
map <Leader>s :w<CR>

" Disable ctrlp working directory - current dir is used
let g:ctrlp_working_path_mode = 'r'

" ctrlp ignore settings
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" Setting the Syntastic plugin default checkers
let g:syntastic_html_checkers = ['w3']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_scss_checkers = ['scss_lint']

"" remap quickfix open horizontal split
let g:qfenter_hopen_map = ['<c-x>']
