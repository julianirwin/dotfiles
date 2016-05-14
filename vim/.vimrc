" INITIAL SETTINGS (must go first)
set nocompatible
filetype off

" VUNDLE 
"(Leave just below initial settings)
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" ###### PLUGINS #####
" general
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-git'
Plugin 'scrooloose/syntastic'
Plugin 'mileszs/ack.vim.git'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

"movement/editing
Plugin 'bkad/CamelCaseMotion'
Plugin 'garbas/vim-snipmate'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'PeterRincker/vim-argumentative'
Plugin 'tpope/vim-commentary'

"file nav
Plugin 'vim-scripts/The-NERD-tree.git'
Plugin 'tpope/vim-vinegar'

"colorschemes
Plugin 'tpope/vim-vividchalk'
Plugin 'vol2223/vim-colorblind-colorscheme'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Lokaltog/vim-distinguished'
Plugin 'nanotech/jellybeans.vim'

"sytax
Plugin 'hdima/python-syntax'

"utility
Plugin 'vim-scripts/tlib'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'chrisbra/Colorizer'

"python
Plugin 'fs111/pydoc.vim'
Plugin 'vim-scripts/pep8'

"broken
" Plugin 'ryanb/dotfiles/blob/master/vim/colors/railscasts.vim'
" Plugin 'wincent/Command-T'
" Plugin 'ervandew/supertab'
filetype off
filetype on
filetype plugin on
filetype plugin indent on

" END PLUGINS

" Mangage rtp
set rtp+=~\.vim\snippets

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin on    " required


" TABSTOP SETTINGS
set ts=2	" tabstop
set sw=2	" shiftwidth
set expandtab 	" convert \t to spaces
set smarttab  	 
set smartindent " automatically and intelligently add tabs to next line
" turn on cindent for the following file types:
autocmd FileType sh,c,cpp,java,php,javascript setl cindent
au FileType ruby,html,haml setl shiftwidth=2 tabstop=2
au FileType python setl shiftwidth=4 tabstop=4

""" PANE ELEMENTS """
set nu		" show line numbers
set ruler	" show cursor line and column numbers
set cc=80


""" SEARCH SETTINGS """
set incsearch	" instantly move cursor to next match while patter is typed
set ignorecase	" ignore case by default when searching
set smartcase	" search is case sensitive is search contains a cap letter

""" KEY REMAPPINGS """
inoremap jk <Esc>
nnoremap j gj
nnoremap k gk
nnoremap <C-e> 5<C-e>    " Speed up viewport scrolling
nnoremap <C-y> 5<C-y>
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-c><C-d> cd %:p:h
inoremap <Leader>o <C-x><C-o>
  " Fix the comment goes to first column bug
inoremap # X#

""" plugin specific """
map <leader>n :NERDTreeToggle<CR>
imap <C-a> <Plug>snipMateNextOrTrigger
smap <C-a> <Plug>snipMateNextOrTrigger
let g:cpp_class_scope_highlight = 1

""" tabs """
nnoremap <C-m> gt
nnoremap <C-n> gT
nnoremap <C-w> :tabclose<Enter>
nnoremap <C-t> :tabe<Enter>

""" panes """
nnoremap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-l> :wincmd l<CR>
nmap  :vs<CR>

""" GUI Specific"""
if has("gui_running")
  nnoremap <C-p> "+gp
  vnoremap <C-p> "+gp
  set lines=999 columns=167
endif

""" language specific """
if has("gui_running")
  if has("win32") || has("win16")
    nnoremap <F5> :!START /B python "%"
  else 
    nnoremap <F5> :!python % &
  endif
else
  nnoremap <F5> :!python %
endif

"function keys
" <F1> already mapped to help
nmap <F2> :source $MYVIMRC<CR>
nnoremap <F3> :e $MYVIMRC<Enter>
" <F5> Mapped to run cmd
let g:pep8_map='<F6>'


" MISC
set timeout tm=400         " Timeout for commands with more than one keypress
set backspace=eol,start,indent " allow backspace to overwrite these chars
set exrc	                 " Searches for a .vimrc in this directory
		                       " This allows for a context specific vimrc
set wrap lbr	             " Set line wrapping, but only at word boundaries
set scrolloff=5            " Keep 5 lines above and below the cursor

" SYNTAX HIGHLIGHTING
syntax on  " Turn on syntax highlighting
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:vim_markdown_math=1 " Ignore latex regions in .md files


" CODE FOLDING
set foldmethod=syntax
set foldnestmax=2
set foldlevelstart=20
highlight Folded ctermfg=7 ctermbg=15
highlight FoldColumn ctermfg=7 ctermbg=Grey
source ~/.vim/syntax/python_fold.vim

function! NeatFoldText() "{{{2
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()

" stop the open bracket unfolds all folds below problem:
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" GUI SETTINGS
if has("gui_running")
  colorscheme distinguished
  if has("win32") || has("win16")
    set guifont=Consolas:h11:cANSI
  else
  endif
endif

" PYTHON DOCUMENTATION WINDOW
" au FileType python set omnifunc=pythoncomplete#Complete
" let g:SuperTabDefaultCompletionType = "context"
" set completeopt=menuone,longest,preview

" SUPERTAB
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabNoCompleteAfter = ['^', '\s', '\t']

" PYDOC
let g:pydoc_cmd = 'python -m pydoc'
let g:pydoc_open_cmd = 'tabnew'

" OMNICOMPLETE
autocmd FileType python set omnifunc=pythoncomplete#Complete

" ENCODING
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8                     " better default than latin1
  setglobal fileencoding=utf-8           " change default file encoding when writing new files
endif

let g:snipMate = {}
let g:snips_author='Julian Irwin'
let g:snips_email='julian.irwin@gmail.com'
let g:snips_github='gradi3nt'


" FINAL SETTINGS (must go last)
set secure	" Don't allow autocmd after this point b/c config is done

