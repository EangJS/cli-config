"----------------------------------------------------------------
" Vim configuration file
"----------------------------------------------------------------

"----------------------------------------------------------------
" General settings
"----------------------------------------------------------------
" Disable vi compatibility
if !has("nvim")
	set nocompatible
endif

" Reload .vimrc
nnoremap <F12> :so $MYVIMRC<CR>

" Enable local .vimrc config
set exrc
set secure

" Lines of memory to remember
set history=10000

" Leader key to add extra key combinations
let mapleader = ','
let g:mapleader = ','

" Time delay on <Leader> key
set timeoutlen=3000 ttimeoutlen=100

" Update time
set updatetime=250

" Trigger InsertLeave autocmd
inoremap <C-c> <Esc>

" No need for Ex mode
nnoremap Q <NOP>

" Open help in a vertical window
cnoreabbrev help vert help
" Terminal (nvim)
if has("terminal") && has("nvim")
	nnoremap <silent> <F7> :call <SID>ToggleTerminal()<CR>
	tnoremap <silent> <F7> <C-\><C-n><Bar>:wincmd p<CR>
	tnoremap <Esc> <C-\><C-n>
endif

" Set inc/dec
set nrformats-=octal

"----------------------------------------------------------------
" 2. Plugins (Plug)
"----------------------------------------------------------------
" Install Plugins
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" List of plugins installed
call plug#begin('~/.vim/plugged')

	" Statusbar
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'airblade/vim-gitgutter'

	" Tools
	Plug 'preservim/nerdcommenter', { 'commit': 'a5d1663' }
	Plug 'preservim/nerdtree'
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'

	" Edition
	Plug 'junegunn/vim-easy-align'
	Plug 'godlygeek/tabular'
	Plug 'jiangmiao/auto-pairs'
	Plug 'alvan/vim-closetag'
	Plug 'gerardbm/vim-md-headings'
	Plug 'gerardbm/vim-md-checkbox'
	Plug 'matze/vim-move'

	" Misc
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'tpope/vim-characterize'
	Plug 'tpope/vim-fugitive'
	Plug 'tyrannicaltoucan/vim-deep-space'
call plug#end()

"----------------------------------------------------------------
" 3. Plugins settings
"----------------------------------------------------------------
" --- Statusbar ---
" Airline settings
let g:airline_theme                       = 'luna'
let g:airline_powerline_fonts             = 1
let g:airline_section_z                   = airline#section#create([
			\ '%1p%% ',
			\ 'Ξ%l%',
			\ '\⍿%c'])


" --- Git tools ---
" Gitgutter settings
let g:gitgutter_max_signs             = 5000
let g:gitgutter_sign_added            = '+'
let g:gitgutter_sign_modified         = '»'
let g:gitgutter_sign_removed          = '_'
let g:gitgutter_sign_modified_removed = '»╌'
let g:gitgutter_map_keys              = 0
let g:gitgutter_diff_args             = '--ignore-space-at-eol'

nmap <Leader>j <Plug>(GitGutterNextHunk)zz
nmap <Leader>k <Plug>(GitGutterPrevHunk)zz
nnoremap <silent> <C-g> :call <SID>ToggleGGPrev()<CR>zz
nnoremap <Leader>ga :GitGutterStageHunk<CR>
nnoremap <Leader>gu :GitGutterUndoHunk<CR>

" Fugitive settings
nnoremap <C-s> :call <SID>ToggleGstatus()<CR>
nnoremap <Leader>gv :Gvdiffsplit<CR>:windo set wrap<CR>
nnoremap <Leader>gh :Gvdiffsplit HEAD<CR>:windo set wrap<CR>
nnoremap <Leader>gb :Gblame<CR>

" Searching for text added or removed by a commit
nnoremap <Leader>gg :call <SID>GrepWrapper('Gclog', '-i -G', '--')<CR>

" --- Sessions ---
" Vim-session settings
let g:session_autosave  = 'no'
let g:session_autoload  = 'no'
let g:session_directory = '~/.vim/sessions/'

" --- Tools ---
" NERDCommenter settings
let g:NERDDefaultAlign          = 'left'
let g:NERDSpaceDelims           = 1
let g:NERDCompactSexyComs       = 1
let g:NERDCommentEmptyLines     = 0
let g:NERDCreateDefaultMappings = 0
let g:NERDCustomDelimiters      = {
	\ 'python': {'left': '#'},
	\ }

nnoremap cc :call NERDComment(0,'toggle')<CR>
vnoremap cc :call NERDComment(0,'toggle')<CR>

" NERDTree settings
nnoremap <silent> <C-n> :call <SID>ToggleNERDTree()<CR>


let g:SuperTabDefaultCompletionType = '<TAB>'

" For conceal markers
if has('conceal')
	set conceallevel=0 concealcursor=niv
	nnoremap <silent> coi :set conceallevel=0<CR>:set concealcursor=niv<CR>
	nnoremap <silent> coo :set conceallevel=2<CR>:set concealcursor=vc<CR>
	nnoremap <silent> cop :set conceallevel=2<CR>:set concealcursor=niv<CR>
	nnoremap <silent> com :set conceallevel=3<CR>:set concealcursor=niv<CR>
endif


" --- Edition ---
" Easy align settings
xmap gi <Plug>(EasyAlign)
nmap gi <Plug>(EasyAlign)

" Tabularize (e.g. /= or /:)
vnoremap <Leader>x :Tabularize /

" Tabularize only the first match on the line (e.g. /=.*/)
vnoremap <Leader>X :Tabularize /.*/<Left><Left><Left>

" Auto-pairs settings
" Maps for normal and insert modes
let g:AutoPairsFlyMode        = 0
let g:AutoPairsMultilineClose = 0
let g:AutoPairsShortcutJump   = '<C-z>'
let g:AutoPairsShortcutToggle = '<C-y>'

" Workaround to fix an Auto-pairs bug until it gets fixed
if has("nvim")
	autocmd VimEnter,BufEnter,BufWinEnter * silent! iunmap <buffer> <M-">
endif

" Closetag settings
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.xml,*.html.erb,*.md'

" Expand region settings
vmap v <Plug>(expand_region_expand)
vmap m <Plug>(expand_region_shrink)

" Vim-move settings. Use Shift
let g:move_key_modifier = 'S'
let g:move_key_modifier_visualmode = 'S'

" --- Misc ---
" Vim-tmux navigator settings
let g:tmux_navigator_no_mappings = 1

"----------------------------------------------------------------
" 4. User interface
"----------------------------------------------------------------
" Set X lines to the cursor when moving vertically
set scrolloff=0

" Always show mode
set showmode

" Show command keys pressed
set showcmd

" Enable the WiLd menu
set wildmenu

" Show the current position
set ruler

" Command bar height
set cmdheight=2

" Backspace works on Insert mode
set backspace=eol,start,indent

" Don't redraw while executing macros (good performance config)
set lazyredraw

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set matchtime=2

" No annoying sound on errors
set noerrorbells
set novisualbell

" Mouse
set mouse=a

" Highlight cursor line and cursor column
set cursorline
set nocursorcolumn

" Always show the status line
set laststatus=2

" Change the cursor shape
if !has("nvim")
	if &term != "linux"
		let &t_SI = "\<Esc>[6 q"
		let &t_SR = "\<Esc>[4 q"
		let &t_EI = "\<Esc>[2 q"
	endif
else
	set guicursor=n-v:block-Cursor/lCursor-blinkon0
	set guicursor+=i-ci-c:ver100-Cursor/lCursor-blinkon0
	set guicursor+=r-cr:hor100-Cursor/lCursor-blinkon0
endif

" Omni completion
if has('autocmd') && exists('+omnifunc')
autocmd Filetype *
	\ if &omnifunc == "" |
	\     setlocal omnifunc=syntaxcomplete#Complete |
	\ endif
endif

" Fix italics issue
if !has("nvim")
	let &t_ZH="\e[3m"
	let &t_ZR="\e[23m"
endif

"----------------------------------------------------------------
" 5. Scheme and colors
"----------------------------------------------------------------
" True color
" if !has("nvim")
"   if has("termguicolors")
"       let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"       let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"       set termguicolors
"   endif
" else
"   set termguicolors
" endif

" Syntax highlighting
syntax enable

" Show syntax highlighting groups
nnoremap <Leader>B :call <SID>SynStack()<CR>

" Theme
set background=dark
set termguicolors
colorscheme deep-space

"----------------------------------------------------------------
" 6. Files and backup
"----------------------------------------------------------------
" Disable swap files
set noswapfile

" No backup (use Git instead)
set nobackup

" Prevents automatic write backup
set nowritebackup

" Use UTF-8 as default encoding
set encoding=utf8

" Use Unix as the standard file type
set fileformats=unix,dos,mac

" Autoread a file when it is changed from the outside
set autoread

" Reload a file when it is changed from the outside
let g:f5msg = 'Buffer reloaded.'
nnoremap <F5> :e<CR>:echo g:f5msg<CR>

" Enable filetype plugins
filetype plugin on
filetype indent on

" Allow us to use Ctrl-s and Ctrl-q as keybinds
" Restore default behaviour when leaving Vim.
if !has("nvim")
	silent !stty -ixon
	autocmd VimLeave * silent !stty ixon
endif

" Save the current buffer
nnoremap <Leader>s :update<CR>

" Save all buffers
nnoremap <Leader>S :bufdo update<CR>

" :W sudo saves the file
" (useful for handling the permission-denied error)
cnoremap WW w !sudo tee > /dev/null %

" Rename file
nnoremap <F2> :call <SID>RenameFile()<CR>

" Work on buffer
nnoremap yab :%y<CR>
nnoremap dab :%d<CR>
nnoremap vab ggVG

"----------------------------------------------------------------
" 7. Buffers management
"----------------------------------------------------------------
" Buffer hidden when it is abandoned
set hidden

" Close the current buffer
nnoremap <Leader>bd :call <SID>CustomCloseBuffer()<CR>

" Move between buffers
nnoremap <C-h> :bprev<CR>
nnoremap <C-l> :bnext<CR>

" Edit and explore buffers
nnoremap <Leader>bb :edit <C-R>=expand("%:p:h")<CR>/
nnoremap <Leader>bg :buffers<CR>:buffer<Space>

" Copy the filepath to clipboard
nnoremap <Leader>by :let @+=expand("%:p")<CR>

" Switch CWD to the directory of the current buffer
nnoremap <Leader>dd :lcd %:p:h<CR>:pwd<CR>

" Switch CWD to git root directory
nnoremap <silent> <Leader>dg :call <SID>GitRoot()<CR>

" Ignore case when autocompletes when browsing files
set fileignorecase

" Specify the behavior when switching between buffers
try
	set switchbuf=useopen,usetab,newtab
	set showtabline=2
catch
endtry

" Remember info about open buffers on close
" set viminfo^=%

"----------------------------------------------------------------
" 8. Tabs management
"----------------------------------------------------------------
" Create and close tabs
nnoremap <Leader>td :tabclose<CR>
nnoremap <Leader>to :tabonly<CR>

" Open a new tab with the current buffer's path
" Useful when editing files in the same directory
nnoremap <Leader>tt :tabedit <C-R>=expand("%:p:h")<CR>/

" Move tabs position
nnoremap <Leader>tr :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <Leader>ty :execute 'silent! tabmove ' . tabpagenr()<CR>

"----------------------------------------------------------------
" 9. Multiple windows
"----------------------------------------------------------------
" Remap wincmd
map <Leader>, <C-w>

set winminheight=0
set winminwidth=0
set splitbelow
set splitright
set fillchars+=stlnc:―,vert:│,fold:―,diff:―

" Split windows
map <C-w>- :split<CR>
map <C-w>. :vsplit<CR>
map <C-w>j :close<CR>
map <C-w>x :q!<CR>
map <C-w>, <C-w>=

" Resize windows
if bufwinnr(1)
	map + :resize +1<CR>
	map - :resize -1<CR>
	map < :vertical resize +1<CR>
	map > :vertical resize -1<CR>
endif

" Toggle resize window
nnoremap <silent> <C-w>f :call <SID>ToggleResize()<CR>

" Last, previous and next window; and only one window
nnoremap <silent> <C-w>l :wincmd p<CR>:echo "Last window."<CR>
nnoremap <silent> <C-w>p :wincmd w<CR>:echo "Previous window."<CR>
nnoremap <silent> <C-w>n :wincmd W<CR>:echo "Next window."<CR>
nnoremap <silent> <C-w>o :wincmd o<CR>:echo "Only one window."<CR>

" Move between Vim windows and Tmux panes
" - It requires the corresponding configuration into Tmux.
" - Check it at my .tmux.conf from my dotfiles repository.
" - URL: https://github.com/gerardbm/dotfiles/blob/master/tmux/.tmux.conf
" - Plugin required: https://github.com/christoomey/vim-tmux-navigator
if !has("nvim")
	set <M-h>=h
	set <M-j>=j
	set <M-k>=k
	set <M-l>=l
endif

nnoremap <silent> <M-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <M-j> :TmuxNavigateDown<CR>
nnoremap <silent> <M-k> :TmuxNavigateUp<CR>
nnoremap <silent> <M-l> :TmuxNavigateRight<CR>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader><BS> mmHmt:%s/<C-v><CR>//ge<CR>'tzt`m

" Close the preview window
nnoremap <silent> <Leader>. :pclose<CR>

" Scroll the preview window
if !has("nvim")
	set <M-d>=d
	set <M-u>=u
endif

nnoremap <silent> <M-d> :wincmd P<CR>5<C-e>:wincmd p<CR>
nnoremap <silent> <M-u> :wincmd P<CR>5<C-y>:wincmd p<CR>

"----------------------------------------------------------------
" 10. Indentation tabs
"----------------------------------------------------------------
" Enable autoindent & smartindent
set autoindent
set smartindent

" Use tabs, no spaces
set noexpandtab

" Be smart when using tabs
set smarttab

" Tab size (in spaces)
set shiftwidth=2
set tabstop=2

" Remap indentation
nnoremap <TAB> >>
nnoremap <S-TAB> <<

vnoremap <TAB> >gv
vnoremap <S-TAB> <gv

inoremap <TAB> <C-i>
inoremap <S-TAB> <C-d>

" Don't show tabs
set list

let g:f6msg = 'Toggle list.'
nnoremap <F6> :set list!<CR>:echo g:f6msg<CR>

" Show tabs and end-of-lines
set listchars=tab:┊\ ,trail:¬

"----------------------------------------------------------------
" 11. Moving around lines
"----------------------------------------------------------------
" Specify which commands wrap to another line
set whichwrap+=<,>,h,l

" Many jump commands move the cursor to the start of line
set nostartofline

" Wrap lines into the window
set wrap

" Don't break the words
" Only works if I set nolist (F6)
set linebreak
set showbreak=↳\ 

" Stop automatic wrapping
set textwidth=0

" Column at 80 width
set colorcolumn=80

" Listings don't pause
set nomore

" Color column
let g:f10msg = 'Toggle colorcolumn.'
nnoremap <silent> <F10> :call <SID>ToggleColorColumn()<CR>:echo g:f10msg<CR>

" Show line numbers
set number
set numberwidth=2

let g:f3msg = 'Toggle line numbers.'
nnoremap <silent> <F3> :set number!<CR>:echo g:f3msg<CR>


let g:f4msg = 'Toggle relative line numbers.'
nnoremap <silent> <F4> :set norelativenumber!<CR>:echo g:f4msg<CR>

" Treat long lines as break lines (useful when moving around in them)
nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')

vnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
vnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')

nnoremap <Home> g^
nnoremap <End> g$

vnoremap <Home> g^
vnoremap <End> g$

" Toggle the cursor position start/end of the line
nnoremap <silent> ñ :call <SID>ToggleCPosition('')<CR>
vnoremap <silent> ñ <Esc>:call <SID>ToggleCPosition('normal! gv')<CR>

" Join / split lines
nnoremap <C-j> J
nnoremap <C-k> i<CR><Esc>

" Duplicate a line
nnoremap cx yyP
nnoremap cv yyp

" Folding
set foldmethod=marker

" Return to last edit position when opening files
autocmd BufReadPost *
	\ if line("'\"") > 0 && line("'\"") <= line("$") |
	\   exe "normal! g`\"" |
	\ endif

" --- Readline commands ---
"----------------------------------------------------------------
" Move the cursor to the line start
inoremap <C-a> <C-O>0

" Move the cursor to the line end
inoremap <C-e> <C-O>$

" Moves the cursor back one character
inoremap <expr><C-b> deoplete#smart_close_popup()."\<Left>"

" Moves the cursor forward one character
inoremap <expr><C-f> deoplete#smart_close_popup()."\<Right>"

" Remove one character
inoremap <C-d> <DEL>

" Command Mode
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <DEL>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-v> <C-r>"
cnoremap <C-g> <S-Right><C-w>

"----------------------------------------------------------------
" 12. Paste mode
"----------------------------------------------------------------
" Bracketed paste mode
" - Source: https://ttssh2.osdn.jp/manual/en/usage/tips/vim.html
if !has("nvim")
	if has("patch-8.0.0238")
		if &term =~ "screen"
			let &t_BE = "\e[?2004h"
			let &t_BD = "\e[?2004l"
			exec "set t_PS=\e[200~"
			exec "set t_PE=\e[201~"
		endif
	endif
endif

"----------------------------------------------------------------
" 13. Search, vimgrep and grep
"----------------------------------------------------------------
" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Search, wrap around the end of the buffer
set wrapscan

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" For regular expressions turn magic on
set magic

" Maximum amount of memory in Kbyte used for pattern matching
set maxmempattern=1000

" --- Highlight ---
"----------------------------------------------------------------
" Map <Space> to / (search)
nnoremap <Space> /
nnoremap <Leader><Space> ?

" Highlight the word under the cursor and don't jump to next
nnoremap <silent> <Leader><CR> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hlsearch<CR>

" Highlight the selected text and don't jump to next
vnoremap <silent> <Leader><CR> :<C-U>call <SID>VSetSearch()<CR>:set hlsearch<CR>

" Disable highlight
nnoremap <Leader>m :noh<CR>

" Next and prev centered
nnoremap n nzz
nnoremap N Nzz

" Search into a Visual selection
vnoremap <silent> <Space> :<C-U>call <SID>RangeSearch('/')<CR>
	\ :if strlen(g:srchstr) > 0
	\ \|exec '/'.g:srchstr\|endif<CR>n
vnoremap <silent> ? :<C-U>call <SID>RangeSearch('?')<CR>
	\ :if strlen(g:srchstr) > 0
	\ \|exec '?'.g:srchstr\|endif<CR>N


"----------------------------------------------------------------
" 14. Text edition
"----------------------------------------------------------------
" Toggle case
nnoremap <Leader>z ~
vnoremap <Leader>z y:call setreg('', ToggleCase(@"), getregtype(''))<CR>gv""Pgv
vnoremap ~ y:call setreg('', ToggleCase(@"), getregtype(''))<CR>gv""Pgv

" Toggle and untoggle spell checking
let g:f8msg = 'Toggle spell checking.'
nnoremap <silent> <F8> :setlocal spell!<CR>:echo g:f8msg<CR>

" Toggle spell dictionary
nnoremap <silent> <F9> :call <SID>ToggleSpelllang()<CR>

" Move to next misspelled word
nnoremap zl ]s

" Find the misspelled word before the cursor
nnoremap zh [s

" Suggest correctly spelled words
nnoremap zp z=

" Copy text into the clipboard
vnoremap <Leader>y "+y

" Paste text from the clipboard
nnoremap <Leader>p "+p

" Quickly select the text pasted from the clipboard
nnoremap gV `[v`]

" Yank everything from the cursor to the EOL
nnoremap Y y$

" Yank the last pasted text automatically
vnoremap p pgvy

" Retab the selected text
nnoremap <Leader>tf :retab!<CR>
vnoremap <Leader>tf :retab!<CR>

" Isolate the current line
nnoremap <Leader>o m`o<Esc>kO<Esc>``

" Enter a new line Down from 'Normal Mode'
nnoremap <Leader>f mao<Esc>`a

" Enter a new line Up from 'Normal Mode'
nnoremap <Leader>F maO<Esc>`a

" Insert brackets and backslash faster
inoremap ñr []<left>
inoremap ñb ()<left>
inoremap ñB {}<left>
inoremap ññ \
inoremap çç {{  }}<left><left><left>
autocmd FileType html,markdown,liquid inoremap ñp {%  %}<left><left><left>

" Enter Vim's expression register (math)
inoremap ñc <C-r>=

"----------------------------------------------------------------
" 15. Make settings
"----------------------------------------------------------------
" Set makeprg
if !filereadable(expand('%:p:h').'/Makefile')
	autocmd FileType c setlocal makeprg=gcc\ %\ &&\ ./a.out
endif

" Go to the error line
set errorformat=%m\ in\ %f\ on\ line\ %l

" Use the correct cursor shape via 'edit-command-line' (zle)
augroup zsh
	autocmd!
	if !has("nvim")
		autocmd Filetype zsh silent! exec "! echo -ne '\e[2 q'"
	endif
augroup end

" Run code in a tmux window
augroup tmuxy
	autocmd!
	autocmd FileType javascript,lua,perl,php,python,ruby,sh
				\ nnoremap <silent> <buffer> <Leader>ij
				\ :call <SID>Tmuxy()<CR>
augroup end

" Run code in the preview window
augroup scripty
	autocmd!
	autocmd FileType javascript,lua,perl,php,python,ruby,sh
				\ nnoremap <silent> <buffer> <Leader>ii
				\ :call <SID>Scripty()<CR>
augroup end

" Work with Sqlite databases
augroup sqlite
	autocmd!
	autocmd FileType sql nnoremap <silent> <Leader>ia
				\ :call <SID>SqliteDatabase()<CR>
	autocmd FileType sql nnoremap <silent> <buffer> <Leader>ii
				\ :call <SID>SQLExec('n')<CR>
	autocmd FileType sql vnoremap <silent> <buffer> <Leader>ii
				\ :<C-U>call <SID>SQLExec('v')<CR>
augroup end

" Work with maxima (symbolic mathematics)
augroup maxima
	autocmd!
	autocmd BufRead,BufNewFile *.max set filetype=maxima
	autocmd FileType maxima nnoremap <silent> <buffer> <Leader>ii
				\ :call <SID>MaximaExec('n')<CR>
	autocmd FileType maxima vnoremap <silent> <buffer> <Leader>ii
				\ :<C-U>call <SID>MaximaExec('v')<CR>
augroup end

" Convert LaTeX to PDF
augroup latex
	autocmd!
	autocmd FileType tex nnoremap <silent> <buffer> <Leader>ii
				\ :call <SID>Generator('.pdf', &ft)<CR>
augroup end

" Convert markdown to PDF, HTML and EPUB
augroup markdown
	autocmd!
	autocmd FileType markdown nnoremap <silent> <buffer> <Leader>ii
				\ :call <SID>Generator('.pdf', &ft)<CR>
	autocmd FileType markdown nnoremap <silent> <buffer> <Leader>ih
				\ :call <SID>Generator('.html', &ft)<CR>
	autocmd FileType markdown nnoremap <silent> <buffer> <Leader>ij
				\ :call <SID>Generator('.epub', &ft)<CR>
augroup end

" Draw with PlantUML
augroup uml
	autocmd!
	autocmd FileType plantuml nnoremap <silent> <buffer> <Leader>ii
				\ :call <SID>Generator('.png', &ft)<CR>
augroup end

" Draw with Graphviz
augroup dot
	autocmd!
	autocmd FileType dot nnoremap <silent> <buffer> <Leader>ii
				\ :call <SID>Generator('.png', &ft)<CR>
augroup end

" Draw with Eukleides
augroup eukleides
	autocmd!
	autocmd BufRead,BufNewFile *.euk set filetype=eukleides
	autocmd FileType eukleides nnoremap <silent> <buffer> <Leader>ii
				\ :call <SID>Generator('.png', &ft)<CR>
augroup end

" Draw with Asymptote
augroup asymptote
	autocmd!
	autocmd BufRead,BufNewFile *.asy set filetype=asy
	autocmd FileType asy nnoremap <silent> <buffer> <Leader>ii
				\ :call <SID>Generator('.png', &ft)<CR>
augroup end

" Draw with pp3
augroup pp3
	autocmd!
	autocmd BufRead,BufNewFile *.pp3 set filetype=pp3
	autocmd FileType pp3 nnoremap <silent> <buffer> <Leader>ii
				\ :call <SID>Generator('.png', &ft)<CR>
augroup end

" Draw with Gnuplot
augroup gnuplot
	autocmd!
	autocmd BufRead,BufNewFile *.plt set filetype=gnuplot
	autocmd FileType gnuplot nnoremap <silent> <buffer> <Leader>ii
				\ :call <SID>Generator('.png', &ft)<CR>
augroup end

" Draw with POV-Ray
augroup povray
	autocmd!
	autocmd FileType pov nnoremap <silent> <buffer> <Leader>ii
				\ :call <SID>Generator('.png', &ft)<CR>
augroup end

" Run Jekyll (liquid)
augroup liquid
	autocmd!
	autocmd FileType liquid,html,yaml set wildignore+=*/.jekyll-cache/*,
				\*/_site/*,*/images/*,*/timg/*,*/icons/*,*/logo/*,*/where/*
	autocmd FileType liquid setlocal spell spelllang=es colorcolumn=0
	autocmd FileType liquid,yaml nnoremap <silent> <buffer> <Leader>ii
				\ :call <SID>ToggleJekyll()<CR>
	autocmd FileType liquid,md nnoremap <silent> <buffer> <Leader>ij
				\ :call <SID>ViewJekyllPost()<CR>
augroup end

"----------------------------------------------------------------
" 16. Filetype settings
"----------------------------------------------------------------
" Delete trailing white spaces
func! s:DeleteTrailing()
	exe 'normal mz'
	%s/\s\+$//ge
	exe 'normal `z'
	echo 'Trailing white spaces have been removed.'
	noh
endfunc

nnoremap <silent> <Leader>dt :call <SID>DeleteTrailing()<CR>

" Binary
augroup binary
	autocmd!
	autocmd BufReadPre  *.bin let &bin=1
	autocmd BufReadPost *.bin if &bin | %!xxd
	autocmd BufReadPost *.bin set ft=xxd | endif
	autocmd BufWritePre *.bin if &bin | %!xxd -r
	autocmd BufWritePre *.bin endif
	autocmd BufWritePost *.bin if &bin | %!xxd
	autocmd BufWritePost *.bin set nomod | endif
augroup end

" Mail
augroup mail
	autocmd!
	autocmd FileType mail setl spell
	autocmd FileType mail setl spelllang=ca
augroup end

" SQL (it requires sqlparse)
augroup sql
	let g:omni_sql_no_default_maps = 1
	autocmd FileType sql nnoremap <Leader>bf
				\ :%!sqlformat --reindent --keywords upper --identifiers upper -<CR>
	autocmd FileType sql vnoremap <Leader>bf
				\ :%!sqlformat --reindent --keywords upper --identifiers upper -<CR>
augroup end

" XML (it requires tidy)
augroup xml
	autocmd FileType xml nnoremap <Leader>bf
				\ :%!tidy -q -i -xml --show-errors 0 -wrap 0 --indent-spaces 4<CR>
augroup end

" MD
augroup md
	autocmd FileType markdown,liquid,text,yaml set expandtab
	autocmd FileType markdown,liquid,text
				\ nnoremap <silent> <Leader>cc :call <SID>KeywordDensity()<CR>
	autocmd FileType markdown,liquid,text nnoremap <silent> <Leader>cx g<C-g>
	autocmd FileType markdown,liquid,text vnoremap <silent> <Leader>cx g<C-g>
	autocmd FileType markdown,liquid,text
				\ nnoremap <silent> gl :call search('\v\[[^]]*]\([^)]*\)', 'W')<CR>
	autocmd FileType markdown,liquid,text
				\ nnoremap <silent> gh :call search('\v\[[^]]*]\([^)]*\)', 'bW')<CR>
	autocmd FileType markdown,liquid,text
				\ nnoremap <silent> gd :call <SID>RemoveMdLink()<CR>
	autocmd FileType markdown,liquid,text
				\ :command! -range Enes <line1>,<line2>!trans en:es -brief
	autocmd FileType markdown,liquid,text
				\ :command! -range Esen <line1>,<line2>!trans es:en -brief
	autocmd FileType markdown,liquid,text
				\ nnoremap <silent> gx :call <SID>CustomGx()<CR>
augroup end

" CSV
augroup csv
	autocmd!
	autocmd BufRead,BufNewFile *.csv set filetype=csv
augroup end

" New file headers
augroup headers
	autocmd!
	autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl>\#
				\ -*- coding: utf-8 -*-\<nl>\"|$
	autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl>\"|$
	autocmd BufNewFile *.pl 0put =\"#!/usr/bin/env perl\<nl>\"|$
	autocmd BufNewFile *.sh 0put =\"#!/usr/bin/env bash\<nl>\"|$
	autocmd BufNewFile *.js 0put =\"#!/usr/bin/env node\<nl>\"|$
augroup end
